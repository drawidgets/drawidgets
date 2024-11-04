import 'package:drawidgets/src/decorate.dart';
import 'package:drawidgets/src/inherit.dart';
import 'package:drawidgets/src/theme.dart';
import 'package:flutter/widgets.dart';

enum SidebarStatus {
  show,
  hide,

  /// The sidebar should show,
  /// but the windows is resized that it's too narrow to display the sidebar,
  /// so it is hidden now, but once the window is width enough, it will show.
  narrow;
}

class SidebarContainer extends StatefulWidget {
  const SidebarContainer({
    super.key,
    this.sidebarTheme = AreaTheme.placeholder,
    this.borderColor = Colors.brick,
    this.primary = true,
    this.sidebarWidth = 245,
    this.sidebarMinWidth = 200,
    this.sidebarMaxWidth = 450,
    required this.sidebar,
    required this.child,
  })  : assert(sidebarWidth >= sidebarMinWidth),
        assert(sidebarWidth <= sidebarMaxWidth);

  final AreaTheme sidebarTheme;
  final Color borderColor;

  /// Whether the sidebar is on the start side
  /// according to the [Directionality] ([TextDirection]) in context.
  /// For example, if [primary] is true and [TextDirection.ltr],
  /// the sidebar will be on the left side.
  final bool primary;
  final double sidebarWidth;
  final double sidebarMinWidth;
  final double sidebarMaxWidth;

  final Widget sidebar;
  final Widget child;

  @override
  State<SidebarContainer> createState() => _SidebarContainerState();
}

class _SidebarContainerState extends State<SidebarContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final directionalityLtr = Directionality.of(context) == TextDirection.ltr;
    final sidebarOnLeft = directionalityLtr == widget.primary;

    final sidebar = Positioned(
      top: 0,
      bottom: 0,
      left: sidebarOnLeft ? 0 : null,
      right: sidebarOnLeft ? null : 0,
      width: widget.sidebarWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            strokeAlign: BorderSide.strokeAlignOutside,
            color: widget.borderColor,
          ),
          color: widget.sidebarTheme.background,
        ),
        child: Foreground(
          color: widget.sidebarTheme.foreground,
          child: widget.sidebar,
        ),
      ),
    );

    final main = Positioned.fill(
      left: sidebarOnLeft ? widget.sidebarWidth : 0,
      right: sidebarOnLeft ? 0 : widget.sidebarWidth,
      child: widget.child,
    );

    return InheritData(
      data: SidebarStatus.show,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [main, sidebar],
      ),
    );
  }
}

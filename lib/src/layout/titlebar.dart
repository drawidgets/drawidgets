import 'package:drawidgets/src/decorate.dart';
import 'package:drawidgets/src/theme.dart';
import 'package:flutter/widgets.dart';

class TitlebarContainer extends StatelessWidget {
  const TitlebarContainer({
    super.key,
    this.titlebarTheme = AreaThemeData.placeholder,
    this.borderColor = Colors.brick,
    this.titlebarHeight = 46,
    required this.child,
  });

  final AreaThemeData titlebarTheme;
  final Color borderColor;
  final double titlebarHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final titlebar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: titlebarHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor)),
          color: titlebarTheme.background,
        ),
        child: Foreground(
          color: titlebarTheme.foreground,
          child: const Align(),
        ),
      ),
    );

    final main = Positioned.fill(
      top: titlebarHeight,
      child: child,
    );

    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [main, titlebar],
    );
  }
}

import 'package:flutter/widgets.dart';

class PopupContainer extends StatefulWidget {
  const PopupContainer({
    super.key,
    required this.popup,
    required this.child,
  });

  final Widget popup;
  final Widget child;

  @override
  State<PopupContainer> createState() => _PopupContainerState();
}

class _PopupContainerState extends State<PopupContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [Positioned.fill(child: widget.child)],
    );
  }
}

class BlurPopupContainer extends StatefulWidget {
  const BlurPopupContainer({
    super.key,
    required this.popup,
    required this.child,
  });

  final Widget popup;
  final Widget child;

  @override
  State<BlurPopupContainer> createState() => _BlurPopupContainerState();
}

class _BlurPopupContainerState extends State<BlurPopupContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [Positioned.fill(child: widget.child)],
    );
  }
}

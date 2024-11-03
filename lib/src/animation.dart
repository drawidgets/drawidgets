import 'package:flutter/widgets.dart';

/// Perform animation upon the [data] change.
///
/// You need to specify how to [lerp] and how the [builder] builds its child.
/// This widget is similar to the [AnimatedBuilder],
/// but the parameters and performance are optimized
/// to avoid unnecessary extends and defines of classes.
class AnimateData<T> extends StatefulWidget {
  const AnimateData({
    super.key,
    this.duration = const Duration(milliseconds: 265),
    this.curve = Curves.easeInOut,
    required this.lerp,
    required this.data,
    required this.builder,
  });

  final Duration duration;
  final Curve curve;
  final T Function(T a, T b, double t) lerp;
  final T data;
  final Widget Function(BuildContext context, T data) builder;

  @override
  State<AnimateData<T>> createState() => _AnimateDataState();
}

class _AnimateDataState<T> extends State<AnimateData<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<T> _tween = Tween(widget.data, widget.data);
  late T _data = widget.data;

  void updateData() {
    setState(() {
      _data = widget.lerp(
        _tween.begin,
        _tween.end,
        _controller.value,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)..addListener(updateData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimateData<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != _data) {
      _tween = Tween(_data, widget.data);
      _controller.reset();
      _controller.animateTo(
        _controller.upperBound,
        duration: widget.duration,
        curve: widget.curve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _data);
  }
}

/// Similar to the `Tween` provided by Flutter,
/// but this one avoids unnecessary overrides
/// and provide a non-nullable value interface to improve performance.
class Tween<T> {
  const Tween(this.begin, this.end);

  final T begin;
  final T end;
}

int lerpInt(int a, int b, double t) => a + ((b - a) * t).round();

/// Optimization over the default `lerpDouble` function provided by Flutter:
/// avoid unnecessary nullable checks.
double lerpDouble(double a, double b, double t) => a + (b - a) * t;

/// Optimization over the default [Color.lerp] provided by Flutter:
/// avoid unnecessary nullable checks.
Color lerpColor(Color a, Color b, double t) {
  return Color.fromARGB(
    lerpInt(a.alpha, b.alpha, t),
    lerpInt(a.red, b.red, t),
    lerpInt(a.green, b.green, t),
    lerpInt(a.blue, b.blue, t),
  );
}

import 'package:drawidgets/src/animation.dart';
import 'package:drawidgets/src/theme/theme_base.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum ThemeMode {
  system,
  light,
  dark;
}

class ThemeAdapt<T extends ThemeDataBase> extends StatefulWidget {
  const ThemeAdapt({
    super.key,
    this.mode = ThemeMode.system,
    required this.dark,
    required this.light,
    required this.builder,
  });

  final ThemeMode mode;
  final T dark;
  final T light;
  final Widget Function(BuildContext context, T theme) builder;

  @override
  State<ThemeAdapt<T>> createState() => _ThemeAdaptState();
}

class _ThemeAdaptState<T extends ThemeDataBase> extends State<ThemeAdapt<T>>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final shouldDark = widget.mode == ThemeMode.system
        ? PlatformDispatcher.instance.platformBrightness == Brightness.dark
        : widget.mode == ThemeMode.dark;
    final theme = shouldDark ? widget.dark : widget.light;
    return widget.builder(context, theme);
  }
}

ThemeAdapt<T> animatedThemeAdapt<T extends ThemeDataBase>({
  Key? key,
  Duration duration = const Duration(milliseconds: 325),
  Curve curve = Curves.easeInOut,
  ThemeMode mode = ThemeMode.system,
  required T Function(T, T, double) lerp,
  required T dark,
  required T light,
  required Widget Function(BuildContext, T) builder,
}) {
  return ThemeAdapt<T>(
    key: key,
    dark: dark,
    light: light,
    builder: (context, theme) {
      return AnimateData<T>(
        duration: duration,
        curve: curve,
        lerp: lerp,
        data: theme,
        builder: builder,
      );
    },
  );
}

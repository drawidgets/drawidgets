/// Custom theme templates: create your own theme without limitation of
/// the templates from the `material` or `cupertino` library.
///
/// You can `extends` the [ThemeDataBase] class to create your own theme data,
/// and create a `Theme` class that extends the [ThemeBase] class to apply it.
/// The [ThemeAdapt] widget will help you to adapt platform system theme mode,
/// and you can also use the [animatedThemeAdapt] function to
/// specify the animation of theme change.
///
/// This library provides a full toolchain that you don't need to rely on
/// the `material` or `cupertino` library anymore.
/// For example, this library provides a [ThemeMode] enum itself
/// to avoid unnecessary import of the `material` or `cupertino` library.
library;

import 'package:drawidgets/src/animation.dart';
import 'package:drawidgets/src/decorate.dart';
import 'package:drawidgets/src/inherit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Theme data of an area with only [foreground] and [background] colors.
/// It also provides a [lerp] static method for animation.
class AreaThemeData {
  const AreaThemeData({
    required this.foreground,
    required this.background,
  });

  final Color foreground;
  final Color background;

  static const placeholder = AreaThemeData(
    foreground: Colors.black,
    background: Colors.gray,
  );

  static AreaThemeData lerp(AreaThemeData a, AreaThemeData b, double t) {
    return AreaThemeData(
      background: lerpColor(a.background, b.background, t),
      foreground: lerpColor(a.foreground, b.foreground, t),
    );
  }
}

/// Apply the foreground and background according to the [theme].
class AreaTheme extends StatelessWidget {
  const AreaTheme({
    super.key,
    required this.theme,
    required this.child,
  });

  final AreaThemeData theme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.background,
      child: Foreground(
        color: theme.foreground,
        child: child,
      ),
    );
  }
}

class AreaThemeSolid extends AreaTheme {
  const AreaThemeSolid({
    super.key,
    required super.theme,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.background,
      child: ForegroundSolid(
        color: theme.foreground,
        child: child,
      ),
    );
  }
}

class ThemeDataBase extends AreaThemeData {
  const ThemeDataBase.light({
    this.brightness = Brightness.light,
    super.foreground = Colors.ink,
    super.background = Colors.snow,
  });

  const ThemeDataBase.dark({
    this.brightness = Brightness.dark,
    super.foreground = Colors.chalk,
    super.background = Colors.coal,
  });

  final Brightness brightness;
}

class ThemeBase<T extends ThemeDataBase> extends StatelessWidget {
  const ThemeBase({
    super.key,
    required this.theme,
    required this.child,
  });

  final T theme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InheritData(
      data: theme,
      child: AreaThemeSolid(
        theme: theme,
        child: child,
      ),
    );
  }
}

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

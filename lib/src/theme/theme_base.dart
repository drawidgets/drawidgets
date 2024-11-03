import 'package:drawidgets/src/animation.dart';
import 'package:drawidgets/src/decorate.dart';
import 'package:drawidgets/src/inherit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
      child: AreaTheme(
        theme: theme,
        child: child,
      ),
    );
  }
}

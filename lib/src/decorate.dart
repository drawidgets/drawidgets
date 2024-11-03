import 'package:flutter/widgets.dart';

class Foreground extends StatelessWidget {
  const Foreground({
    super.key,
    required this.color,
    required this.child,
  });

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget textForeground({required Color color, required Widget child}) {
      final style = DefaultTextStyle.of(context).style;
      if (style.color == color) return child;
      return DefaultTextStyle(
        style: style.copyWith(color: color),
        child: child,
      );
    }

    Widget iconForeground({required Color color, required Widget child}) {
      final theme = IconTheme.of(context);
      if (theme.color == color) return child;
      return IconTheme(
        data: theme.copyWith(color: color),
        child: child,
      );
    }

    return textForeground(
      color: color,
      child: iconForeground(
        color: color,
        child: child,
      ),
    );
  }
}

/// A collection of useful colors.
///
/// This `extension` is originally an `abstract final class`,
/// like the `Colors` class with the same name in the `material` library.
/// This is designed for convenience in common code editors
/// including VSCode and Android Studio,
/// because the code completion is much more slower when using a class here.
/// All the fields are `static const` so there's no difference
/// between their usage and even after compile.
extension Colors on Color {
  static const transparent = Color(0x00000000);

  // Mono colors.
  static const white = Color(0xffffffff);
  static const snow = Color(0xfffdfeff);
  static const paper = Color(0xfff7f6f5);
  static const lunar = Color(0xffecebea);
  static const chalk = Color(0xffcecdcc);
  static const gray = Color(0xff7f7f7f);
  static const ink = Color(0xff454647);
  static const night = Color(0xff232425);
  static const blackboard = Color(0xff101211);
  static const coal = Color(0xff0c0b0b);
  static const black = Color(0xff000000);

  // Accent colors.
  static const brick = Color(0xff804044);
}

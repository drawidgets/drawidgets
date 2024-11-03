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

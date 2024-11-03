/// Miscellaneous utilities.
library;

import 'package:flutter/widgets.dart';

/// Ensure that the [Text] widget can display normally.
///
/// The [Text] widget requires [MediaQuery] and [Directionality] in context.
/// [WidgetsApp]s such as `MaterialApp` and `CupertinoApp` already have them.
/// But once there's no such [WidgetsApp] ancestor,
/// the [Text] widget will throw an error
/// because the lack of required environment in context.
///
/// It's strongly not recommended to use it for release
/// as the cost for performance.
/// It's designed for testing without `material` library.
class EnsureTextEnvironment extends StatelessWidget {
  const EnsureTextEnvironment({
    super.key,
    this.media,
    this.direction = TextDirection.ltr,
    required this.child,
  });

  final MediaQueryData? media;
  final TextDirection direction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget ensureMedia({required Widget child}) {
      if (MediaQuery.maybeOf(context) == media) return child;
      return MediaQuery(
        data: media ?? MediaQueryData.fromView(View.of(context)),
        child: child,
      );
    }

    Widget ensureDirection({required Widget child}) {
      if (Directionality.maybeOf(context) == direction) return child;
      return Directionality(
        textDirection: direction,
        child: child,
      );
    }

    return ensureMedia(
      child: ensureDirection(
        child: child,
      ),
    );
  }
}

import 'package:flutter/widgets.dart';

class InheritData<T> extends InheritedWidget {
  const InheritData({
    super.key,
    required this.data,
    required super.child,
  });

  final T data;

  @override
  bool updateShouldNotify(covariant InheritData<T> oldWidget) {
    return data != oldWidget.data;
  }
}

class InheritAPI<T> extends InheritData<T> {
  const InheritAPI({
    super.key,
    required super.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritData<T> oldWidget) => false;
}

/// Format the message of cannot find such data in context,
/// including the corresponding type of [widget] and [data].
String contextNoData(Type widget, Type data) {
  return 'cannot find $widget or $InheritData<$data> in context';
}

/// Format the message of cannot find such API in context,
/// including the corresponding type of [widget] and [data].
String contextNoAPI(Type widget, Type data) {
  return 'cannot find $widget or $InheritAPI<$data> in context';
}

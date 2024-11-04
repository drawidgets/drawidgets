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

extension FindContext on BuildContext {
  T? maybeFind<T>() {
    return dependOnInheritedWidgetOfExactType<InheritData<T>>()?.data;
  }

  T? maybeFindAPI<T>() {
    return dependOnInheritedWidgetOfExactType<InheritAPI<T>>()?.data;
  }

  T find<T>() {
    final data = maybeFind<T>();
    assert(data != null, 'cannot find $InheritData<$T> in context');
    return data! as T;
  }

  T findAPI<T>() {
    final data = maybeFindAPI<T>();
    assert(data != null, 'cannot find $InheritAPI<$T> in context');
    return data!;
  }
}

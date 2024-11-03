import 'package:drawidgets/drawidgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('inherit', () {
    testWidgets('inherit data', (t) async {
      const message = ExampleData('message');
      final layout = Builder(
        builder: (context) {
          return Center(
            child: Text(Example.of(context).message),
          );
        },
      );
      await t.pumpWidget(
        EnsureTextEnvironment(
          child: Example(
            data: message,
            child: layout,
          ),
        ),
      );
      expect(find.text(message.message), findsOneWidget);
    });

    testWidgets('inherit API', (t) async {
      const message = ExampleData('message');
      final layout = Builder(
        builder: (context) {
          return Center(
            child: Text(ExampleAPI.of(context).message),
          );
        },
      );
      await t.pumpWidget(
        EnsureTextEnvironment(
          child: ExampleAPI(
            data: message,
            child: layout,
          ),
        ),
      );
      expect(find.text(message.message), findsOneWidget);
    });
  });
}

class Example extends InheritData<ExampleData> {
  const Example({
    super.key,
    required super.data,
    required super.child,
  });

  static ExampleData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Example>()?.data;
  }

  static ExampleData of(BuildContext context) {
    final data = maybeOf(context);
    assert(data != null, contextNoData(Example, ExampleData));
    return data!;
  }
}

class ExampleAPI extends InheritAPI<ExampleData> {
  const ExampleAPI({
    super.key,
    required super.data,
    required super.child,
  });

  static ExampleData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleAPI>()?.data;
  }

  static ExampleData of(BuildContext context) {
    final data = maybeOf(context);
    assert(data != null, contextNoAPI(ExampleAPI, ExampleData));
    return data!;
  }
}

class ExampleData {
  const ExampleData(this.message);

  final String message;
}

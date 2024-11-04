import 'package:drawidgets/drawidgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('inherit', () {
    const message = 'message';

    testWidgets('inherit data', (t) async {
      final layout = Builder(
        builder: (context) {
          final message = context.find<String>();
          return Center(child: Text(message));
        },
      );
      await t.pumpWidget(
        EnsureTextEnvironment(
          child: InheritData(
            data: message,
            child: layout,
          ),
        ),
      );
      expect(find.text(message), findsOneWidget);
    });

    testWidgets('inherit API', (t) async {
      final layout = Builder(
        builder: (context) {
          final message = context.findAPI<String>();
          return Center(child: Text(message));
        },
      );
      await t.pumpWidget(
        EnsureTextEnvironment(
          child: InheritAPI(
            data: message,
            child: layout,
          ),
        ),
      );
      expect(find.text(message), findsOneWidget);
    });
  });
}

import 'package:drawidgets/drawidgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ensure text environment', (t) async {
    const message = 'message';
    await t.pumpWidget(
      const EnsureTextEnvironment(
        child: Center(
          child: Text(message),
        ),
      ),
    );
    expect(find.text(message), findsOneWidget);
  });
}

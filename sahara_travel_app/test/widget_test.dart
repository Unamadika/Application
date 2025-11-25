// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:sahara_travel_app/main.dart';

void main() {
  testWidgets('Sahara app renders splash screen copy', (tester) async {
    await tester.pumpWidget(const SaharaApp());
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Sahara Travel Companion'), findsOneWidget);

    // Allow splash timers to complete so the test can exit cleanly.
    await tester.pump(const Duration(milliseconds: 2000));
  });
}

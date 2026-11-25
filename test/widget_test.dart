import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_app/main.dart';

// These tests check the input screen only. They never call Flask, so they
// work without the server running.
void main() {
  testWidgets('input screen shows 4 fields and a Predict button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const IrisApp());

    expect(find.byType(TextField), findsNWidgets(4));
    expect(find.text('Predict'), findsOneWidget);
  });

  testWidgets('empty fields show an error and stay on the input screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const IrisApp());

    await tester.tap(find.text('Predict'));
    await tester.pump();

    expect(find.text('Please enter 4 valid numbers'), findsOneWidget);
    expect(find.text('Result'), findsNothing);
  });

  testWidgets('letters and NaN are rejected as measurements',
      (WidgetTester tester) async {
    await tester.pumpWidget(const IrisApp());

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'abc');
    await tester.enterText(fields.at(1), '3.5');
    await tester.enterText(fields.at(2), '1.4');
    await tester.enterText(fields.at(3), 'NaN');

    await tester.tap(find.text('Predict'));
    await tester.pump();

    expect(find.text('Please enter 4 valid numbers'), findsOneWidget);
    expect(find.text('Result'), findsNothing);
  });
}
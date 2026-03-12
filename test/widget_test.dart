// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:_42_the_flutter_multiverse/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Food Scanner app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: FoodScannerApp()));

    // Wait for async providers to settle.
    await tester.pumpAndSettle();

    // Verify that the app title is displayed.
    expect(find.text('Food Scanner'), findsOneWidget);

    // Verify that the barcode input field is present.
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the empty state message is shown.
    expect(find.text('Enter a barcode to search'), findsOneWidget);

    // Verify that the reset button is present.
    expect(find.byIcon(Icons.refresh), findsOneWidget);

    // Verify that the camera button is present.
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);

    // Verify that the search icon is present.
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}

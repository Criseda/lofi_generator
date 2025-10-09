// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lofi_generator/main.dart';

void main() {
  testWidgets('Initial UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title and initial UI elements are present.
    expect(find.text('Lofi Generator'), findsOneWidget);
    expect(find.text('Test Audio'), findsOneWidget);

    // Verify that the play button is shown initially.
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);

    // Verify that the pause and replay buttons are not shown initially.
    expect(find.byIcon(Icons.pause), findsNothing);
    expect(find.byIcon(Icons.replay), findsNothing);
  });
}
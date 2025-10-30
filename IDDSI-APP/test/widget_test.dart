// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dysphagia_care_app/app.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame with required parameters
    await tester.pumpWidget(
      const IDDSIApp(
        hasSeenWelcome: false,
        firebaseInitialized: false,
      ),
    );

    // Verify the app loads without errors
    expect(find.byType(MaterialApp), findsOneWidget);

    // Wait for any animations or async operations to complete
    await tester.pumpAndSettle();

    // Add your specific widget tests here based on your app's content
    // For example, if you have a welcome screen when hasSeenWelcome is false:
    // expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets('App with welcome screen seen', (WidgetTester tester) async {
    // Test the app when user has already seen the welcome screen
    await tester.pumpWidget(
      const IDDSIApp(
        hasSeenWelcome: true,
        firebaseInitialized: true,
      ),
    );

    await tester.pumpAndSettle();

    // Verify the app navigates to the main screen
    // Add assertions based on your app's routing logic
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:divercity_fontend/main.dart';

void main() {
  testWidgets('App loads with splash screen', (WidgetTester tester) async {
    // Create basic theme data for testing
    final lightTheme = ThemeData.light();
    final darkTheme = ThemeData.dark();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(theme: lightTheme, darkTheme: darkTheme));

    // Verify that the splash screen is displayed
    expect(find.text('DiverCity'), findsOneWidget);
    expect(find.text('Your Dive Companion'), findsOneWidget);
    expect(find.byIcon(Icons.scuba_diving), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

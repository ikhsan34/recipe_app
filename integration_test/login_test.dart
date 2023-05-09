import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:recipe_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Test', (WidgetTester tester) async {

    app.main();

    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'test@gmail.com');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, '123456');

    Finder loginButton = find.byKey(const Key('login-button'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);

  });

  testWidgets('Search Recipe', (WidgetTester tester) async {

    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Login'), findsWidgets);
    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'test@gmail.com');
    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, '123456');
    Finder loginButton = find.byKey(const Key('login-button'));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    expect(find.text('Dashboard'), findsOneWidget);

    Finder searchNav = find.byTooltip('search-navbar');
    await tester.tap(searchNav);
    await tester.pumpAndSettle();

    Finder searchForm = find.byKey(const Key('search'));
    await tester.enterText(searchForm, 'chicken');
    await tester.pumpAndSettle();

    Finder searchButton = find.byKey(const Key('search-button'));
    await tester.tap(searchButton);
    await tester.pumpAndSettle();

    expect(find.byType(AnimatedList), findsWidgets);

  });

}
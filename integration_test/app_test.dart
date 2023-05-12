import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:recipe_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login and Profile Test', (WidgetTester tester) async {

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

    Finder profileButton = find.byKey(const Key('profile-button'));
    expect(profileButton, findsOneWidget);
    await tester.tap(profileButton);
    await tester.pumpAndSettle();
    expect(find.text('test@gmail.com'), findsWidgets);

    Finder logoutButton = find.byKey(const Key('logout-button'));
    await tester.tap(logoutButton);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('logout-button-menu')));
    await tester.pumpAndSettle();

  });

  testWidgets('App Flow', (WidgetTester tester) async {

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

    Finder recipeItem = find.text('Chicken Vesuvio').hitTestable();
    await tester.tap(recipeItem);
    await tester.pumpAndSettle();
    expect(recipeItem, findsWidgets);

    Finder addButton = find.byKey(const Key('save-button'), skipOffstage: false);
    await tester.ensureVisible(addButton);
    await tester.pumpAndSettle();
    expect(addButton, findsOneWidget);

    await tester.tap(addButton);
    await tester.pumpAndSettle();
    expect(find.text('This recipe is already saved'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    Finder homeNav = find.byTooltip('home-navbar');
    await tester.tap(homeNav);
    await tester.pumpAndSettle();

    await tester.tap(recipeItem);
    await tester.pumpAndSettle();
    expect(recipeItem, findsWidgets);

    Finder deleteButton = find.byKey(const Key('delete-button'), skipOffstage: false);
    await tester.ensureVisible(deleteButton);
    await tester.pumpAndSettle();
    expect(deleteButton, findsOneWidget);

    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

  });

}
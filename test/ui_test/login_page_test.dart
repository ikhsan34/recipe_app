import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:recipe_app/screens/auth/auth_provider.dart';
import 'package:recipe_app/screens/auth/login_screen.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_provider.dart';

import '../mock.dart';

Widget testApp(Widget widget) {
  return MaterialApp(
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: widget,
    ),
  );
}

void main() {

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  
  testWidgets('Login Page', (WidgetTester tester) async {

    await tester.pumpWidget(testApp(const LoginScreen()));
    expect(find.text('Login'), findsWidgets);

  });

}
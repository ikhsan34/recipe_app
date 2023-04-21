import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/auth/auth_provider.dart';
import 'package:recipe_app/screens/auth/login_screen.dart';
import 'package:recipe_app/screens/auth/register_screen.dart';
import 'package:recipe_app/screens/dashboard/dashboard_screen.dart';
import 'package:recipe_app/screens/dashboard/recipe/detail_recipe_screen.dart';
import 'package:recipe_app/screens/profile_screen.dart';
import 'package:recipe_app/screens/dashboard/recipe/recipe_provider.dart';
import 'package:recipe_app/screens/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light, 
            primary: Color(0xFF009688), 
            onPrimary: Colors.white, 
            secondary: Color(0xFF607D8B), 
            onSecondary: Colors.white, 
            error: Colors.red, 
            onError: Colors.white, 
            background: Colors.grey, 
            onBackground: Colors.black, 
            surface: Colors.white, 
            onSurface: Colors.black
          ),

        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/profile': (context) => const ProfileScreen()
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/detail_recipe') {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return DetailRecipeScreen(recipeName: args);
              },
            );
          }
        },
      ),
    );
  }
}
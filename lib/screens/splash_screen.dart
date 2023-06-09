import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:recipe_app/screens/auth/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/shared/loadings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), (() async {
      final bool isLoggedIn = await Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
      if (isLoggedIn) {
        if(!mounted) return;
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        if(!mounted) return;
        Navigator.pushReplacementNamed(context, '/login');
      }
    }));
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        // Preload InAppWebView widget
        const InAppWebView(),
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Recipe App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 10),
              const Text('Recipes for your cooking', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 100),
              Loadings.fadingCircle(),
            ],
          ),
        ),
      ]
    );
  }
}
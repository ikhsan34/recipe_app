import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/auth/auth_provider.dart';
import 'package:recipe_app/shared/loadings.dart';
import 'package:recipe_app/shared/snakbar.dart';
import 'package:recipe_app/shared/styles.dart';
import 'package:recipe_app/shared/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 0,
      ),
      body: isLoading
      ? Loadings.fadingCircle()
      : SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Recipe App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2
                    ),
                  )
                ),
                const SizedBox(height: 50),
                const Text('Email', style: TextStyle(color: Colors.white)),
                TextFormField(
                  validator: (value) => Validator.validateEmail(email: value),
                  controller: emailController,
                  decoration: emailInputDecoration
                ),
                const SizedBox(height: 20),
                const Text('Password', style: TextStyle(color: Colors.white)),
                TextFormField(
                  validator: (value) => Validator.validatePassword(password: value),
                  controller: passwordController,
                  obscureText: true,
                  decoration: passwordInputDecoration
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: submitButtonStyle,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        bool result = await auth.signInUsingEmailPassword(email: emailController.text, password: passwordController.text);
                        if (result) {
                          if(!mounted) return;
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        } else {
                          if(!mounted) return;
                          snackBar(context, 'Login failed, make sure email and password is correct.');
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                Row(
                  children: [
                    const Text('Dont have an account?'),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent)
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Register', style: TextStyle(color: Colors.white),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
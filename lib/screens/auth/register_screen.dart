import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/auth/auth_provider.dart';
import 'package:recipe_app/shared/loadings.dart';
import 'package:recipe_app/shared/styles.dart';
import 'package:recipe_app/shared/validators.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  bool failed = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Register'),
        elevation: 0,
      ),
      body: isLoading
      ? Loadings.fadingCircle()
      : SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name', style: TextStyle(color: Colors.white)),
                TextFormField(
                  validator: (value) => Validator.validateName(name: value),
                  controller: nameController,
                  decoration: nameInputDecoration
                ),
                const SizedBox(height: 20),
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
                const Text('Confirm Password', style: TextStyle(color: Colors.white)),
                TextFormField(
                  validator: (value) => Validator.validatePassword(password: value),
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: confirmPasswordInputDecoration
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: submitButtonStyle,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (passwordController.text != confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Make sure confirmation password is correct')));
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          final result = await auth.registerUsingEmailPassword(name: nameController.text, email: emailController.text, password: passwordController.text);
                          if (result) {
                            if(!mounted) return;
                            Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
                          } else {
                            if(!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Register failed, make sure email is not registered.'))
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
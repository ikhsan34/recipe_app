import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/auth/auth_provider.dart';

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
  bool failed = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context, listen: false);

    final spinkit = SpinKitFadingCircle(
      color: Colors.grey[350],
      size: 100,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 0,
      ),
      body: isLoading
      ? spinkit
      : SingleChildScrollView(
        child: Form(
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
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'email',
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Password', style: TextStyle(color: Colors.white)),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'password',
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)                    
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                      minimumSize: MaterialStateProperty.all(const Size.fromHeight(40))
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool result = await auth.signInUsingEmailPassword(email: emailController.text, password: passwordController.text);
                      if (result) {
                        if(!mounted) return;
                        Navigator.pushReplacementNamed(context, '/dashboard');
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
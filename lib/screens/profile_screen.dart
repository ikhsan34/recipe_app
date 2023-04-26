import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/auth/auth_provider.dart';
import 'package:recipe_app/screens/dashboard/recipe/services/recipe_provider.dart';
import 'package:recipe_app/shared/loadings.dart';
import 'package:recipe_app/shared/snakbar.dart';
import 'package:recipe_app/shared/validators.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isEditing = false;
  bool changePassword = false;
  bool isLoading = false;
  double opacity = 0;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void getUser() {
    final User user = Provider.of<AuthProvider>(context, listen: false).user!;
    setState(() {
      nameController.text = user.displayName ?? '';
      emailController.text = user.email ?? '';
    });
  }
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void submitEditProfile(BuildContext context) async {
    setState(() {
    isLoading = true;
    });
    final bool result = await Provider.of<AuthProvider>(context, listen: false).editProfile(
      name: nameController.text.trim(), 
      email: emailController.text.trim(), 
      password: passwordController.text
    );
    if (result) {
      if(!mounted) return;
      snackBar(context, 'Edit profile success, please re-loggin');
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        Provider.of<AuthProvider>(context, listen: false).logout();
        Provider.of<RecipeProvider>(context, listen: false).disposeRecipe();
      });
    } else {
      setState(() {
        isLoading = false;
      });
      if(!mounted) return;
      snackBar(context, 'Edit profile failed, please check your internet connection');
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<AuthProvider>(context).user!;
    final String name = user.displayName!;
    final String email = user.email!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      maxRadius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(Icons.person, size: 30),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7)
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(thickness: 2, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(height: 10),

              // Form
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Want to change your profile data? Enable edit here.'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Edit Profile: '),
                        Switch(
                          value: isEditing, 
                          onChanged: (value) {
                            setState(() {
                              isEditing = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) => Validator.validateName(name: value),
                      controller: nameController,
                      enabled: isEditing,
                      decoration: const InputDecoration(
                        labelText: 'Your name',
                        filled: true,
                        border: InputBorder.none
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) => Validator.validateEmail(email: value),
                      controller: emailController,
                      enabled: isEditing,
                      decoration: const InputDecoration(
                        labelText: 'Your email',
                        filled: true,
                        border: InputBorder.none
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedOpacity(
                      opacity: isEditing ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Change password?'),
                              Switch(
                                value: changePassword, 
                                onChanged: !isEditing ? null : (value) {
                                  setState(() {
                                    changePassword = value;
                                    passwordController.text = '';
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  opacity: changePassword ? 1 : 0,
                                  child: TextFormField(
                                    validator: !changePassword ? null : (value) => Validator.validatePassword(password: value),
                                    controller: passwordController,
                                    enabled: isEditing,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'New password',
                                      filled: true,
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                isLoading
                                ? Loadings.simpleCircleLoading(context)
                                : AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  top: changePassword ? 80 : 0,
                                  child: ElevatedButton(
                                    onPressed: !isEditing ? null : () async {
                                      if (formKey.currentState!.validate()) {
                                        submitEditProfile(context);
                                      }
                                    },
                                    child: const Text('Save Edit'),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
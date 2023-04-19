import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/firebase_options.dart';


class AuthProvider extends ChangeNotifier {

  User? user;

  Future<bool> isLoggedIn() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      return true;
    }
    return false;
  }
  
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user!.reload();
      user = auth.currentUser;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
    return false;
  }

}
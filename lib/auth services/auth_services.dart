import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final authState = FirebaseAuth.instance.authStateChanges();
  User? user = FirebaseAuth.instance.currentUser;

  // void signInWithEmailPassword(BuildContext context) async {
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //       email: 'admin@gmail.com',
  //       password: '12345678',
  //     );
  //     // User is signed in, you can access userCredential.user
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("No user found for that email."),
  //         ),
  //       );
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("Wrong password provided for that user."),
  //         ),
  //       );
  //     }
  //   }
  // }

  Future signIn(String email, String password) async {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // void signUpWithEmailPassword(BuildContext context) async {
  //   try {
  //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //       email: 'userone@gmail.com',
  //       password: '87654321',
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("The password provided is too weak."),
  //         ),
  //       );
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text("The account already exists for that email."),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<UserCredential> signUp(String email, String password) async {
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

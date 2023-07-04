import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:questanaire_app/auth%20services/auth_services.dart';
import 'package:questanaire_app/screens/register_screen.dart';
import 'package:questanaire_app/widgets/snackBar.dart';
import '../responsive/responsive.dart';
import '../widgets/text_field_style.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();

AuthServices authServices = AuthServices();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: R.sw(36, context),
            // vertical: R.sh(36, context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Qizo",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: R.sw(48, context),
                  ),
                ),
              ),
              SizedBox(
                height: R.sh(42, context),
              ),
              Text(
                "Login to your Account",
                style: TextStyle(
                  fontSize: R.sw(14, context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: R.sh(24, context),
              ),
              TextFieldStyle(
                hintText: "Email",
                controller: emailController,
              ),
              SizedBox(
                height: R.sh(12, context),
              ),
              TextFieldStyle(
                hintText: "Password",
                controller: passwordController,
              ),
              SizedBox(
                height: R.sh(24, context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 6,
                  backgroundColor: Colors.blue[900],
                  minimumSize: Size(
                    R.sw(375, context),
                    R.sh(40, context),
                  ),
                ),
                onPressed: () async {
                  var email = emailController.text;
                  var password = passwordController.text;

                  try {
                    final User? user =
                        (await authServices.signIn(email, password)).user;
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    showSnackBar(context, e.message);
                  }
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(),
                ),
              ),
              SizedBox(
                height: R.sh(24, context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: R.sw(12, context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      " Sign up",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                        fontSize: R.sw(12, context),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

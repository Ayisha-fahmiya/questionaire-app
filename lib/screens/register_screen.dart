import 'package:flutter/material.dart';

import '../responsive/responsive.dart';
import '../widgets/text_field_style.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();
TextEditingController userNameController = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: R.sw(36, context),
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
                "Create your Account",
                style: TextStyle(
                  fontSize: R.sw(14, context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: R.sh(24, context),
              ),
              TextFieldStyle(
                hintText: "name",
                controller: userNameController,
              ),
              SizedBox(
                height: R.sh(12, context),
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
                  if (emailController.text == "" &&
                      passwordController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Username and password can't be empty"),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Sign up",
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
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: R.sw(12, context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      " Log in",
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

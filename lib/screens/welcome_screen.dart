import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questanaire_app/provider/auth_provider.dart';
import 'package:questanaire_app/responsive/responsive.dart';
import 'package:questanaire_app/screens/home_screen.dart';
import 'package:questanaire_app/screens/register_screen.dart';
import 'package:questanaire_app/widgets/custom_button.dart';

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({super.key});

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: R.sh(25, context),
              horizontal: R.sw(35, context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/image1.png",
                  height: R.sh(300, context),
                ),
                SizedBox(height: R.sh(20, context)),
                Text(
                  "Lest's get started",
                  style: TextStyle(
                    fontSize: R.sw(22, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: R.sh(10, context)),
                Text(
                  "Never a better time than now to start",
                  style: TextStyle(
                    fontSize: R.sw(14, context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(height: R.sh(20, context)),
                CustomButton(
                  onPressed: () async {
                    if (ap.isSignIn) {
                      await ap.getDataFromSP().whenComplete(
                            () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            ),
                          );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    }
                  },
                  text: "Get Started",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:questanaire_app/provider/auth_provider.dart';
import 'package:questanaire_app/screens/home_screen.dart';
import 'package:questanaire_app/screens/register_screen.dart';
import 'package:questanaire_app/screens/user_info_screen.dart';
import 'package:questanaire_app/widgets/custom_button.dart';
import 'package:questanaire_app/widgets/snackBar.dart';

import '../responsive/responsive.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    var code = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: R.sh(24, context),
                    horizontal: R.sw(24, context),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        width: R.sw(200, context),
                        height: R.sh(200, context),
                        padding: EdgeInsets.all(R.sw(20, context)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.shade50,
                        ),
                        child: Image.asset(
                          "assets/images/image3.png",
                        ),
                      ),
                      SizedBox(height: R.sh(20, context)),
                      Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: R.sw(22, context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: R.sh(10, context)),
                      Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                          fontSize: R.sw(14, context),
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: R.sh(20, context)),
                      Pinput(
                        onChanged: (value) {
                          code = value;
                        },
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: R.sw(60, context),
                          height: R.sw(60, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.purple.shade200,
                            ),
                          ),
                          textStyle: TextStyle(
                            fontSize: R.sw(20, context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                          print(otpCode);
                        },
                      ),
                      SizedBox(height: R.sh(24, context)),
                      CustomButton(
                        text: "Verify",
                        onPressed: () async {
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: RegisterScreen.verify,
                              smsCode: code,
                            );

                            await auth.signInWithCredential(credential);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                                (route) => false);
                            // if (otpCode != null) {
                            //   verifyOtp(context, otpCode!);
                            // } else {
                            //   showSnackBar(context, "Enter 6-digit code");
                            // }
                          } catch (e) {
                            showSnackBar(context, "Enter 6-digit code");
                          }
                        },
                      ),
                      SizedBox(height: R.sh(20, context)),
                      Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: R.sw(12, context),
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: R.sh(20, context)),
                      Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: R.sw(14, context),
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        ap.checkExistingUser().then((value) async {
          if (value == true) {
            // existing user
            ap.getDataFromFirestore().then(
                  (value) => ap.saveUserDataToSP().then(
                        (value) => ap.setSignIn().then(
                              (value) => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (route) => false),
                            ),
                      ),
                );
          } else {
            // new user
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoScreen(),
                ),
                (route) => false);
          }
        });
      },
    );
  }
}

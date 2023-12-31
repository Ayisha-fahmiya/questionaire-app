import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:questanaire_app/provider/auth_provider.dart';
import 'package:questanaire_app/screens/welcome_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomScreen(),
        // initialRoute: "phone",
        // routes: {
        //   "phone": (context) => RegisterScreen(),
        //   "otp": (context) => OTPScreen(verificationId: ''),
        //   "home": (context) => HomeScreen(),
        // },
      ),
    );
  }
}

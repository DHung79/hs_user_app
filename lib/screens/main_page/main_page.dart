import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< Updated upstream:lib/screens/main_page/main_page.dart
import 'package:home_services/screens/otp_screen/otp_screen.dart';
import '../login_screen/login_screen.dart';
=======
import 'package:hs_user_app/screens/otpscreen/otpscreen.dart';

import '../loginscreen/loginscreen.dart';
>>>>>>> Stashed changes:lib/screens/mainpage/mainpage.dart

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const OtpScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

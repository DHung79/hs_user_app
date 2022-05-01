import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:hs_user_app/screens/homecsreen/bookingpage/bookingpage.dart';
>>>>>>> Stashed changes

import 'screens/login_screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
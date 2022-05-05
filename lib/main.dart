import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/controllers/login_controller.dart';
import 'screens/login_screen/login_screen.dart';
import 'screens/otp_screen/otp_screen.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(LoginController());
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(() {
        if (controller.googleAccount.value != null) {
          return const OtpScreen();
        } else {
          return const LoginScreen();
        }
      }),
    );
  }
}

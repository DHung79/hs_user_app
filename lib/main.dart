import 'package:flutter/material.dart';
import 'package:home_services/screens/homecsreen/bookingpage/bookingpage.dart';

import 'screens/login_screen/login_screen.dart';
import 'widgets/task_widget.dart';

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
      home: const BookingPage(),
    );
  }
}

import 'package:flutter/material.dart';
import '/screens/homecsreen/home_navigation.dart';
import '/screens/notificationscreen/notifiscreen.dart';
import 'screens/homecsreen/bookingpage/post_task/post_task_page.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostTask(),
    );
  }
}

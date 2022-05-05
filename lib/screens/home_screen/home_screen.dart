import 'package:flutter/material.dart';
import 'package:hs_user_app/screens/home_screen/components/home_navigation.dart';

import 'booking/booking.dart';
import 'components/home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeContent(),
    const Booking(),
    const HomeContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Scaffold(
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: HomeNavigation(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )),
      ),
    );
  }
}

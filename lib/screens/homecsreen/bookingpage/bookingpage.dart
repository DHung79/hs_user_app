import 'package:flutter/material.dart';
import 'package:home_services/config/fonts.dart';
import 'package:home_services/config/theme.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _selectIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const Text('dhds'),
    const BookingPage(),
    const Text('Admin')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                    child: TextButton(
                      onPressed:(){
                        _onItemTapped(0);
                      } ,
                      child: Text('Text Button'),
                    ),
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: ColorApp.purpleColor,
                      width: 4,
                    ),
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  // padding: const EdgeInsets.all(16),
                  child: const Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('dang viec'),
                  )),
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: ColorApp.purpleColor,
                      width: 4,
                    ),
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  // padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('dang y viec'),
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: ColorApp.purpleColor,
                      width: 4,
                    ),
                  )),
                ),
              ],
            ),
          ),
          // const Spacer(),
          Expanded(
              child: Center(
            // height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logodemo.png'),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: 161.0,
                  height: 52.0,
                  child: TextButton(
                    child: Text(
                      'Đăng việc ngay',
                      style: FontStyle().registerFont,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorApp.orangeColor),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )),
          // const Spacer(),
        ],
      ),
    );
  }
}

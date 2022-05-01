import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:home_services/config/fonts.dart';
import 'package:home_services/config/theme.dart';
=======
import 'package:hs_user_app/config/fonts.dart';
import 'package:hs_user_app/config/theme.dart';
>>>>>>> Stashed changes
import 'task_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _selectIndex = 0;
  bool add = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void _onAddTask() {
    setState(() {
      add = !add;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, actions: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: _selectIndex == 0
                          ? ColorApp.purpleColor
                          : ColorApp.textColor2,
                      width: 4))),
          child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                _onItemTapped(0);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const LoginScreen()));
              },
              child: Text('Hiện tại', style: FontStyle().lineFont)),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: _selectIndex == 1
                          ? ColorApp.purpleColor
                          : ColorApp.textColor2,
                      width: 4))),
          child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                _onItemTapped(1);
              },
              child: Text('Đăng việc', style: FontStyle().lineFont)),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: _selectIndex == 2
                          ? ColorApp.purpleColor
                          : ColorApp.textColor2,
                      width: 4))),
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                _onItemTapped(2);
              },
              child: Text('Lịch sử', style: FontStyle().lineFont)),
        ),
      ]),
      body: add == false ? emptyTask() : TaskPage(),
    );
  }

  Center emptyTask() {
    return Center(
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
                onPressed: _onAddTask),
          ),
        ],
      ),
    );
  }
}

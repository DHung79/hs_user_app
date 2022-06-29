import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';

import '../../../core/user/model/user_model.dart';
import '../../layout_template/content_screen.dart';
import 'components/task_history.dart';
import 'components/task_now.dart';
import 'components/task_page.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final PageState _pageState = PageState();
  bool add = false;
  void _onItemTapped(int index) {
    setState(() {
      selectIndexBooking = index;
    });
  }

  List booking = [
    TaskPage(
      key: taskPageKey,
    ),
    const TaskNow(),
    TaskHistory(
      key: taskHistoryKey,
    ),
  ];

  void _onAddTask() {
    setState(() {
      add = !add;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          return PageContent(
            child: content(context), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Scaffold content(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        backgroundColor: Colors.white,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: selectIndexBooking == 0
                        ? AppColor.primary1
                        : Colors.transparent,
                    width: 4),
              ),
            ),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  _onItemTapped(0);
                },
                child: Text(
                  'Đăng việc',
                  style: selectIndexBooking == 0
                      ? AppTextTheme.normalText(AppColor.primary1)
                      : AppTextTheme.normalText(AppColor.text3),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: selectIndexBooking == 1
                            ? AppColor.primary1
                            : Colors.transparent,
                        width: 4))),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  _onItemTapped(1);
                },
                child: Text(
                  'Hiện tại',
                  style: selectIndexBooking == 1
                      ? AppTextTheme.normalText(AppColor.primary1)
                      : AppTextTheme.normalText(AppColor.text3),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: selectIndexBooking == 2
                            ? AppColor.primary1
                            : Colors.transparent,
                        width: 4))),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  _onItemTapped(2);
                },
                child: Text(
                  'Lịch sử',
                  style: selectIndexBooking == 2
                      ? AppTextTheme.normalText(AppColor.primary1)
                      : AppTextTheme.normalText(AppColor.text3),
                )),
          ),
        ],
      ),
      body: booking.elementAt(selectIndexBooking),
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
                style: AppTextTheme.headerTitle(AppColor.text2),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.primary2),
              ),
              onPressed: _onAddTask,
            ),
          ),
        ],
      ),
    );
  }
}

void _fetchDataOnPage() {
}

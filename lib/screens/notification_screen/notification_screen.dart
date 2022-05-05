import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/config/theme.dart';
import '/config/fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.textColor2,
        title: Text(
          'Thông báo',
          style: FontStyle().serviceFont,
        ),
        centerTitle: true,
        actions: [SvgPicture.asset('assets/icons/17078.svg')],
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/17079.svg',
            width: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        // scrollDirection: Axis.horizontal,
        children: <Widget>[
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
          contentNoti(),
        ],
      ),
    );
  }

  Container contentNoti() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              left: BorderSide(
                width: 4.0,
                color: ColorApp.orangeColor,
              ),
              bottom: BorderSide(
                  color: Color.fromRGBO(243, 244, 244, 1), width: 1))),
      padding: const EdgeInsets.only(left: 10, top: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 19),
            child: CircleAvatar(
              backgroundColor: ColorApp.purpleColor,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tasker hủy công việc',
                  style: FontStyle().topNavActive,
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Nguyễn Phúc Vĩnh Kỳ đã hủy công việc của bạn',
                    style: FontStyle().topNavNotActive,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Vừa mới',
                  style: FontStyle().timeDeleteTask,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

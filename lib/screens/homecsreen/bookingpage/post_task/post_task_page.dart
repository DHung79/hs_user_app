import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hs_user_app/config/fonts.dart';

import '../../../../config/theme.dart';

class PostTask extends StatefulWidget {
  const PostTask({Key? key}) : super(key: key);

  @override
  State<PostTask> createState() => _PostTaskState();
}

class _PostTaskState extends State<PostTask> {
  int valueWeek = 0;
  int value = 0;
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SvgPicture.asset('assets/icons/17073.svg'),
        title: Text(
          'Dọn dẹp nhà cửa',
          style: FontStyle().serviceFont,
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Địa điểm', style: FontStyle().serviceFont),
            const SizedBox(
              height: 24,
            ),
            location(),
            const SizedBox(
              height: 32,
            ),
            Text('Thời lượng', style: FontStyle().serviceFont),
            const SizedBox(
              height: 24,
            ),
            room(3, 100, 3, 1),
            const SizedBox(
              height: 24,
            ),
            room(4, 150, 4, 2),
            const SizedBox(
              height: 24,
            ),
            room(3, 109, 2, 3),
            const SizedBox(
              height: 32,
            ),
            timeWork(),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
            child: Row(children: [
              pickTimeWork('24', 'MON', 0),
              pickTimeWork('25', 'TUE', 1),
              pickTimeWork('26', 'WED', 2),
              pickTimeWork('27', 'THU', 3),
              pickTimeWork('28', 'FRI', 4),
              pickTimeWork('29', 'SAT', 5),
              pickTimeWork('30', 'SUN', 6),
            ]),
          ),
        ),
        // const SizedBox(
        //   height: 12,
        // ),
        noteTasker(),
        contentSwitch(),
        const SizedBox(
          height: 71,
        ),
        payButton(),
      ]),
    );
  }

  Container noteTasker() {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(children: [
          timeStart(),
          const SizedBox(
            height: 51,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ghi chú cho người làm',
                style: FontStyle().titleStart,
              ),
              const SizedBox(
                  height: 144,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: ColorApp.textColor6),
                        ),
                      ),
                    ),
                  ))
            ],
          )
        ]),
      );
  }

  Container payButton() {
    return Container(
        padding: const EdgeInsets.all(16),
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: ColorApp.bgPay,
              padding: const EdgeInsets.all(16)),
          onPressed: () {},
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '200.000 VNĐ/2h',
                  style: FontStyle().registerFont,
                ),
                Text(
                  'TIẾP THEO',
                  style: FontStyle().registerFont,
                )
              ]),
        ),
      );
  }

  Container contentSwitch() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Danh sách công việc', style: FontStyle().titleStart),
            Text(
              'Tạo danh sách công việc cho người làm',
              style: FontStyle().createListTask,
            )
          ],
        ),
        Transform.scale(
            scale: 1,
            child: Switch(
              onChanged: toggleSwitch,
              value: isSwitched,
              activeColor: ColorApp.orangeColor,
              activeTrackColor: ColorApp.activeSwitch,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: ColorApp.notactiveSwitch,
            ))
      ]),
    );
  }

  Container timeStart() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.24),
            blurStyle: BlurStyle.outer,
            blurRadius: 10,
            spreadRadius: 4)
      ]),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/17073.svg',
                  color: ColorApp.purpleColor,
                  width: 24,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Giờ bắt đầu',
                  style: FontStyle().titleStart,
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorApp.bgTimeStart),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 38, right: 38),
              child: Text(
                '8:30 AM',
                style: FontStyle().pickTimeStart,
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget pickTimeWork(String title, String content, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          valueWeek = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: valueWeek == index
              ? Border.all(width: 1, color: Colors.transparent)
              : Border.all(width: 1, color: ColorApp.orangeColor),
          color: valueWeek == index ? ColorApp.orangeColor : null,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            title,
            style: valueWeek == index
                ? FontStyle().contentTask
                : FontStyle().serviceFont,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            content,
            style: valueWeek == index
                ? FontStyle().contentTask
                : FontStyle().serviceFont,
          ),
        ]),
      ),
    );
  }

  Row timeWork() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Thời gian làm việc',
          style: FontStyle().serviceFont,
        ),
        Text(
          'tháng 3, 2022',
          style: FontStyle().timeRoom,
        )
      ],
    );
  }

  Widget room(int time, int sizeRoom, int room, int index) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            value = index;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: (value == index)
                ? null
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.24),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 10,
                      // spreadRadius: 4),
                    ),
                  ],
            border: (value == index)
                ? Border.all(width: 2, color: ColorApp.orangeColor)
                : Border.all(width: 2, color: Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '$time tiếng',
                  style: FontStyle().timeRoom,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '$sizeRoom m2 / $room phòng',
                  style: FontStyle().sizeRoom,
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ));
  }

  Container location() {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.24),
              blurStyle: BlurStyle.outer,
              blurRadius: 10,
              spreadRadius: 4),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 19, bottom: 19, right: 16, left: 20.5),
        child: Row(children: [
          SvgPicture.asset(
            'assets/icons/17073.svg',
            width: 15,
          ),
          const SizedBox(
            width: 14.5,
          ),
          Text('Chọn địa chỉ', style: FontStyle().pickMap),
        ]),
      ),
    );
  }
}

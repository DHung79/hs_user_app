import 'package:flutter/material.dart';
import '/config/fonts.dart';
import '/config/theme.dart';

class SettingScreen extends StatelessWidget {
  List<Infor> fakeProfile = [
    Infor('Payment', 'Đánh giá ứng dụng', 'Ngôn ngữ', 'Đăng xuất'),
  ];

  List<Icon> icons = [
    const Icon(Icons.access_alarm, color: ColorApp.colorIcons, size: 24),
    const Icon(Icons.back_hand_rounded, color: ColorApp.colorIcons, size: 24),
    const Icon(Icons.cabin_sharp, color: ColorApp.colorIcons, size: 24),
    const Icon(Icons.dark_mode_rounded, color: ColorApp.colorIcons, size: 24),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Cài đặt',
          style: FontStyle().serviceFont,
        ),
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            child: Row(children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.black26,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nguyen Duc Hoang Phi',
                    style: FontStyle().serviceFont,
                  ),
                  Text(
                    'nguyenduchoaphi22016@gmail.com',
                    style: FontStyle().gmailText,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Xem hồ sơ',
                          style: FontStyle().viewProfile,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: ColorApp.orangeColor,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(79, 117, 140, 0.16),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 16.0)
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return _item(index, info: fakeProfile[0]);
              },
              itemCount: icons.length,
            ),
          )
        ]),
      ),
    );
  }

  Widget _item(int i, {required Infor info}) {
    String text = '';
    if (i == 0) {
      text = info.payment;
    } else if (i == 1) {
      text = info.rating;
    } else if (i == 2) {
      text = info.language;
    } else {
      text = info.logout;
    }
    // print(i++);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1, color: ColorApp.bgTimeStart),
      )),
      child: Row(
        children: [
          icons[i],
          const SizedBox(
            width: 11,
          ),
          Text(
            text,
            style: FontStyle().textInPostTask,
          ),
        ],
      ),
    );
  }
}

class Infor {
  String payment;
  String rating;
  String language;
  String logout;

  Infor(this.payment, this.rating, this.language, this.logout);
}

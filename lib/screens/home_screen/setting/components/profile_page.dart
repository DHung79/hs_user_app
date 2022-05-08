import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/config/fonts.dart';
import '/config/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Infor> fakeProfile = [
    Infor(
      'juliesnguyen@gmail.com',
      '(+84) 0335475756',
      '358/12/33 Lư Cấm, Ngọc Hiệp - Nha Trang, Khanh Hòa',
    ),
  ];

  List<Icon> icons = [
    const Icon(Icons.access_alarm, color: ColorApp.colorIcons, size: 24),
    const Icon(Icons.back_hand_rounded, color: ColorApp.colorIcons, size: 24),
    const Icon(Icons.cabin_sharp, color: ColorApp.colorIcons, size: 24),
  ];

  hideMoney() {
    String text = '';
    for (var i = 0; i < money.length; i++) {
      text += '*';
    }
    return text;
  }

  String money = '3434';
  bool showMoney = true;

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
                    child: Text(
                      'Đổi mật khẩu',
                      style: FontStyle().viewProfile,
                    ),
                  ),
                ],
              )
            ]),
          ),
          contact(context),
          const SizedBox(
            height: 32,
          ),
          contentProfile(context),
        ]),
      ),
    );
  }

  Container contact(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Color.fromRGBO(79, 117, 140, 0.16),
                blurRadius: 16.0),
          ]),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Liên lạc',
              style: FontStyle().serviceFont,
            ),
            SvgPicture.asset(
              'assets/icons/17073.svg',
              width: 24,
              color: ColorApp.textColor3,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return _item(index, info: fakeProfile[0]);
          },
          itemCount: icons.length,
        )
      ]),
    );
  }

  Container _item(i, {required Infor info}) {
    String text = '';
    if (i == 0) {
      text = info.email;
    } else if (i == 1) {
      text = info.numberPhone;
    } else {
      text = info.address;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          icons[i],
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 98,
            child: Text(
              text,
              style: FontStyle().topNavNotActive,
            ),
          )
        ],
      ),
    );
  }

  Container contentProfile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurStyle: BlurStyle.outer,
                color: Color.fromRGBO(79, 117, 140, 0.16),
                blurRadius: 16.0),
          ]),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ví điện tử',
              style: FontStyle().serviceFont,
            ),
            SvgPicture.asset(
              'assets/icons/17073.svg',
              width: 24,
              color: ColorApp.textColor3,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 19.0, bottom: 19.0, left: 6.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/17073.svg',
                width: 24,
                color: ColorApp.textColor3,
              ),
              const SizedBox(
                width: 22,
              ),
              Row(
                children: [
                  Text(
                    showMoney == true ? money : hideMoney(),
                    style: FontStyle().topNavNotActive,
                  ),
                  Text(
                    ' VND',
                    style: FontStyle().topNavNotActive,
                  )
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                child: Text(
                  'Hiển thị',
                  style: FontStyle().postNow,
                ),
                onTap: () {
                  setState(() {
                    showMoney = !showMoney;
                  });
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextButton(
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: ColorApp.bgTimeStart,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
            ),
            onPressed: () {},
            child: Text(
              'Nạp thêm tiền',
              style: FontStyle().addMoney,
            ),
          ),
        )
      ]),
    );
  }
}

class Infor {
  String email;
  String numberPhone;
  String address;

  Infor(
    this.email,
    this.numberPhone,
    this.address,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../models/your_profile_model.dart';
import '../../../../config/fonts.dart';
import '../../../../config/theme.dart';

class Confirm extends StatefulWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  String fakeCode = 'JOYTECH';
  final TextEditingController _code = TextEditingController();

  List<YourProfileModel> fakeProfiles = [
    YourProfileModel(
        'Thông tin của bạn',
        'Julies Nguyen',
        '(+84) 0335475756',
        '358/12/33 Lư Cẩm, Ngọc Hiệp - Nha Trang - Khánh Hòa',
        'Thông tin công việc',
        '3 tiếng, 14:00 đến 17:00',
        'thứ 6, 25/03/2022',
        '55 m2 / 2 phòng',
        'Hình thức thanh toán',
        'Thanh toán bằng tiền mặt'),
  ];

  final List<Icon> profileIcons = [
    const Icon(
      Icons.alarm,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.car_rental,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.draw,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.abc,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.accessible_forward_rounded,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.reset_tv_rounded,
      color: Color.fromRGBO(33, 169, 159, 1),
    ),
    const Icon(
      Icons.payment,
      color: Color.fromRGBO(33, 169, 159, 1),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          'assets/icons/17073.svg',
        ),
        backgroundColor: Colors.white,
        leadingWidth: 20,
        title: Text(
          'Xác nhận và thanh toán',
          style: FontStyle().serviceFont,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: profileIcons.length,
            itemBuilder: (BuildContext context, iconIndex) {
              return _item(iconIndex,
                  task: fakeProfiles[0], icons: profileIcons);
            },
          ),
          TextField(
            controller: _code,
            style: FontStyle().topNavActive,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.abc_rounded),
                prefixIcon: fakeCode == _code.text
                    ? const Icon(
                        Icons.done,
                        color: Colors.green,
                      )
                    : null,
                hintText: 'Nhập mã khuyến mãi',
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorApp.textColor6)),
                border: const OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorApp.textColor6)),
                disabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorApp.textColor6)),
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorApp.textColor6))),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                fakeCode == _code.text
                    ? Text(
                        '190,000 VND',
                        style: FontStyle().oldPrice,
                      )
                    : const Text(''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng cộng',
                      style: FontStyle().serviceFont,
                    ),
                    Text(
                      '210,000 VND',
                      style: FontStyle().priceFont,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: ColorApp.bgButton,
                  padding: const EdgeInsets.only(top: 16, bottom: 16)),
              onPressed: () {},
              child: Text(
                'ĐĂNG VIỆC',
                style: FontStyle().registerFont,
              ),
            ),
          )
        ]),
      )),
    );
  }

  Row yourProfile({required String task}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          task,
          style: FontStyle().serviceFont,
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
            backgroundColor: ColorApp.bgNav2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          child: Text(
            'Thay đổi',
            style: FontStyle().changeFont,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget _item(int i,
      {required YourProfileModel task, required List<Icon> icons}) {
    String text = '';
    if (i == 0) {
      text = task.userName;
    } else if (i == 1) {
      text = task.numberPhone;
    } else if (i == 2) {
      text = task.location;
    } else if (i == 3) {
      text = task.hours;
    } else if (i == 4) {
      text = task.week;
    } else if (i == 5) {
      text = task.sizeRoom;
    } else if (i == 6) {
      text = task.pay;
    }

    // print(i++);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          i == 0 ? yourProfile(task: fakeProfiles[0].title) : Row(),
          i == 3 ? yourProfile(task: fakeProfiles[0].title2) : Row(),
          i == 6 ? yourProfile(task: fakeProfiles[0].title3) : Row(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: ColorApp.bgIcons,
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.all(8.0),
                child: icons[i],
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  text,
                  style: FontStyle().topNavNotActive,
                  maxLines: 2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

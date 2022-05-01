import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hs_user_app/config/theme.dart';
import 'package:hs_user_app/widgets/button_widget.dart';
import 'package:hs_user_app/widgets/input_widget.dart';
import 'package:hs_user_app/config/fonts.dart';

class SetPassScreen extends StatelessWidget {
  const SetPassScreen({Key? key, required this.rigesterAccount}) : super(key: key);
  final bool? rigesterAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: rigesterAccount!
          ? Container(
        alignment: Alignment.centerLeft,
        color: ColorApp.purpleColor,
        padding: const EdgeInsets.only(top: 65, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 145,
              decoration: BoxDecoration(
                  color: ColorApp.secondaryColor3,
                  borderRadius: BorderRadius.circular(22)
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      icon: SvgPicture.asset('assets/icons/17073.svg'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 16,),
                  Text('Nhập OTP', style: FontStyle().typeEmailFont,)
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tạo mật khẩu mới', style: FontStyle().missPassFont,),
                const SizedBox(height: 24,),
                Text('Mật khẩu không khớp', style: FontStyle().errorFont2,),
                const SizedBox(height: 24,),
                InputLogin(hintText: 'NHẬP MẬT KHẨU MỚI', showPassWord: false,),
                const SizedBox(height: 24,),
                InputLogin(hintText: 'NHẬP LẠI', showPassWord: false,),
                const SizedBox(height: 24,),
                ButtonLogin(text: 'XÁC NHẬN', login: true, style: FontStyle().loginFont, otp: false,),
              ],
            )
            )
          ],
        ),
      )
          : Container(
        alignment: Alignment.centerLeft,
        color: ColorApp.purpleColor,
        padding: const EdgeInsets.only(top: 65, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 145,
              decoration: BoxDecoration(
                  color: ColorApp.secondaryColor3,
                  borderRadius: BorderRadius.circular(22)
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      icon: SvgPicture.asset('assets/icons/17073.svg'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(width: 16,),
                  Text('Nhập OTP', style: FontStyle().typeEmailFont,)
                ],
              ),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Đặt mật khẩu mới', style: FontStyle().missPassFont,),
                    const SizedBox(height: 24,),
                    Text('Mật khẩu không khớp', style: FontStyle().errorFont2,),
                    const SizedBox(height: 24,),
                    InputLogin(hintText: 'NHẬP MẬT KHẨU MỚI', showPassWord: false,),
                    const SizedBox(height: 24,),
                    InputLogin(hintText: 'NHẬP LẠI', showPassWord: false,),
                    const SizedBox(height: 24,),
                    ButtonLogin(text: 'XÁC NHẬN', login: true, style: FontStyle().loginFont, otp: false,),
                  ],
                )
            )
          ],
        ),
      )
    );
  }
}


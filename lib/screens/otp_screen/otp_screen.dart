import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hs_user_app/screens/login_screen/login_screen.dart';
import 'package:hs_user_app/widgets/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:hs_user_app/config/theme.dart';
import 'package:hs_user_app/config/fonts.dart';

import '../setpassscreen/setpassscreen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ahihi() {
    if (formKey.currentState!.validate() && errorMessage.isEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      // _autovalidateMode = AutovalidateMode.onUserInteraction;
    }
  }

  String errorMessage = '';

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.purpleColor,
      key: scaffoldKey,
      body: Container(
        padding: const EdgeInsets.only(top: 65, left: 16, right: 16),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 145,
              decoration: BoxDecoration(
                  color: ColorApp.secondaryColor1,
                  borderRadius: BorderRadius.circular(22)),
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
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Nhập email',
                    style: FontStyle().typeEmailFont,
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nhập mã OTP',
                    style: FontStyle().missPassFont,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Mã OTP không đúng',
                    style: FontStyle().errorFont,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 60),
                        child: PinCodeTextField(
                          backgroundColor: ColorApp.purpleColor,
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            // color: Colors.green.shade600,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          autoFocus: true,
                          showCursor: true,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          length: 4,
                          obscureText: false,
                          obscuringCharacter: '*',
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            fieldHeight: 40,
                            fieldWidth: 32,
                            activeFillColor: ColorApp.purpleColor,
                            selectedFillColor: ColorApp.purpleColor,
                            // disabledColor: ColorApp.purpleColor,
                            activeColor: Colors.white,
                            selectedColor: Colors.white,
                            inactiveColor: Colors.white,
                            inactiveFillColor: ColorApp.purpleColor,
                          ),
                          cursorColor: Colors.white,
                          animationDuration: const Duration(milliseconds: 300),
                          textStyle: FontStyle().otpTextFont,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          onChanged: (v) {},
                        )),
                  ),
                  ButtonLogin(
                    text: 'TIẾP TỤC',
                    login: true,
                    style: FontStyle().loginFont,
                    otp: true,
                    forward: '/createpass',
                    onPressed: ahihi,
                  ),
                  // const SizedBox(height: 24,),
                  TextButton(
                    child: Text(
                      'Gửi lại',
                      style: FontStyle().sendOTPFont,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

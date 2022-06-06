import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import '../../theme/svg_constants.dart';
import '../onboarding/authentication_screen.dart';
import '/widgets/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ahihi() {
    if (formKey.currentState!.validate() && errorMessage.isEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AuthenticationScreen()));
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
      backgroundColor: AppColor.primary1,
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
                  color: AppColor.secondary1,
                  borderRadius: BorderRadius.circular(22)),
              child: Row(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: SvgIcon(
                          SvgIcons.keyboardBackspace,
                          color: AppColor.primary1,
                          size: 24,
                        ),
                      ),
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
                    style: AppTextTheme.normalText(AppColor.text2),
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
                    style: AppTextTheme.bigText(AppColor.text2),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Mã OTP không đúng',
                    style: AppTextTheme.normalHeaderTitle(AppColor.others1),
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
                          backgroundColor: AppColor.primary1,
                          appContext: context,
                          autoDismissKeyboard: false,
                          pastedTextStyle: const TextStyle(
                            // color: Colors.green.shade600,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          autoFocus: true,
                          showCursor: true,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          length: 4,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            fieldHeight: 40,
                            fieldWidth: 32,
                            activeFillColor: AppColor.primary1,
                            selectedFillColor: AppColor.primary1,
                            // disabledColor: ColorApp.purpleColor,
                            activeColor: Colors.white,
                            selectedColor: Colors.white,
                            inactiveColor: Colors.white,
                            inactiveFillColor: AppColor.primary1,
                          ),
                          cursorColor: Colors.white,
                          animationDuration: const Duration(milliseconds: 300),
                          textStyle: AppTextTheme.bigText(AppColor.text2),
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
                    style: AppTextTheme.headerTitle(AppColor.primary1),
                    otp: true,
                    forward: '/createpass',
                    onPressed: ahihi,
                  ),
                  // const SizedBox(height: 24,),
                  TextButton(
                    child: Text(
                      'Gửi lại',
                      style: AppTextTheme.normalHeaderTitle(AppColor.primary1),
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

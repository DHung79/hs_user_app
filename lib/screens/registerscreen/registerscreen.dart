import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_services/config/theme.dart';
import 'package:home_services/screens/otpscreen/otprigesterscreen.dart';
import 'package:home_services/widgets/button_widget.dart';
import 'package:home_services/widgets/input_widget.dart';
import 'package:home_services/config/fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final String textMiss = 'ahihi@gmail.com';
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMessage = '';
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late bool _isObsure;

  ahihi() {
    if (formKey.currentState!.validate() && errorMessage.isEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OtpRigesterScreen()));
    } else {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: ColorApp.purpleColor,
        padding: const EdgeInsets.only(top: 65, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 44,
              child: CircleAvatar(
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/17072.svg'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Expanded(
                child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đăng kí',
                    style: FontStyle().missPassFont,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: FontStyle().errorFont2,
                    ),
                  if (errorMessage.isNotEmpty)
                    const SizedBox(
                      height: 24,
                    ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 52),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value != textMiss) {
                          setState(() {
                            errorMessage = 'Email không tồn tại';
                          });
                        } else {
                          setState(() {
                            errorMessage = '';
                          });
                        }
                        return null;
                      },
                      cursorColor: Colors.white,
                      autofocus: true,
                      cursorHeight: 10,
                      style: FontStyle().mainFont,
                      decoration: InputDecoration(
                        hintText: 'NHẬP EMAI',
                        filled: true,
                        fillColor: ColorApp.secondaryColor3,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0, color: ColorApp.secondaryColor3)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0, color: ColorApp.secondaryColor3)),
                        hintStyle: FontStyle().mainFont,
                      ),
                      controller: controller,
                      // onSubmitted: (_email) {
                      //   _email = widget.email;
                      //   if(widget.vc!.text == _email) {
                      //     Navigator.pushNamed(context, '/otp');
                      //   } else {
                      //   }
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ButtonLogin(
                    text: 'TIẾP TỤC',
                    login: true,
                    style: FontStyle().loginFont,
                    otp: true,
                    forward: '/otpregister',
                    onPressed: ahihi,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

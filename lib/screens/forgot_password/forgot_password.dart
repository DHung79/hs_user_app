import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/config/theme.dart';
import '/screens/otp_screen/otp_screen.dart';
import '/widgets/button_widget.dart';
import '/config/fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final String textMiss = 'ahihi@gmail.com';
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMessage = '';
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  forgotPassword() {
    if (formKey.currentState!.validate() && errorMessage.isEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const OtpScreen()));
    } else {
      _autovalidateMode = AutovalidateMode.always;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerRight,
        color: ColorApp.purpleColor,
        padding: const EdgeInsets.only(top: 65, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              child: IconButton(
                icon: SvgPicture.asset('assets/icons/17072.svg'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quên mật khẩu',
                      style: FontStyle().missPassFont,
                    ),
                    const SizedBox(
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
                        onFieldSubmitted: (value) {
                          if (value == textMiss) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen()));
                          }
                        },
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
                    // InputLogin(hintText: 'NHẬP EMAI', showPassWord: false, vc: controller, validator: (value){
                    //   print('$value');
                    //   if(value != textMiss) {
                    //     return 'Ahihih';
                    //   }
                    //   return null;
                    // }),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonLogin(
                      text: 'TIẾP TỤC',
                      login: true,
                      style: FontStyle().loginFont,
                      forward: '/otp',
                      otp: false,
                      onPressed: forgotPassword,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

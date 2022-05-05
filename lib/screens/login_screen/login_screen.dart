import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hs_user_app/screens/home_screen/home_screen.dart';
import '../../core/controllers/login_controller.dart';
import '../forgot_password/forgot_password.dart';
import '../register_screen/register_screen.dart';
import '/config/theme.dart';
import '/widgets/button_widget.dart';
import '/config/fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String email = 'admin@gmail.com';
  final String emailPassword = 'admin@admin';
  TextEditingController controllerAccount = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String errorMessage = '';
  String errorMessagePass = '';
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isObsure = true;

  final controller = Get.put(LoginController());

  @override
  void dispose() {
    controllerAccount.dispose();
    controllerPass.dispose();
    super.dispose();
  }

  login() {
    setState(() {
      errorMessage = '';
    });
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.purpleColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logodemo.png'),
              Text(
                errorMessage,
                style: FontStyle().errorFont,
              ),
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
                  // onFieldSubmitted: (value) {
                  //   if(value == textMiss) {
                  //     Navigator.push(context, MaterialPageRoute(
                  //         builder: (context) => const OtpScreen()
                  //     ));
                  //   }
                  // },
                  validator: (value) {
                    if (value != email) {
                      setState(() {
                        errorMessage = 'Sai tài khoản';
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
                  cursorHeight: 20,
                  style: FontStyle().mainFont,
                  decoration: InputDecoration(
                    hintText: 'TÀI KHOẢN',
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
                  controller: controllerAccount,
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
              Container(
                constraints: const BoxConstraints(minHeight: 52),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: TextFormField(
                  // onFieldSubmitted: (value) {
                  //   if (value == textMiss || value2 == textMiss) {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OtpScreen()));
                  //   }
                  // },

                  obscureText: _isObsure,
                  cursorColor: Colors.white,
                  autofocus: true,
                  cursorHeight: 20,
                  style: FontStyle().mainFont,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObsure = !_isObsure;
                        });
                      },
                    ),
                    hintText: 'MẬT KHẨU',
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
                  controller: controllerPass,
                  validator: (value) {
                    if (value != emailPassword) {
                      setState(() {
                        errorMessagePass = 'wrong password';
                      });
                    } else {
                      setState(() {
                        errorMessagePass = '';
                      });
                    }
                    return null;
                  },
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()),
                  );
                },
                child: Text(
                  'Quên mật khẩu',
                  style: FontStyle().textFont,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonLogin(
                text: 'ĐĂNG NHẬP',
                style: FontStyle().loginFont,
                login: true,
                otp: false,
                onPressed: login,
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonLogin(
                text: 'ĐĂNG NHẬP VỚI GOOGLE',
                style: FontStyle().googleFont,
                login: false,
                otp: false,
                onPressed: () {
                  controller.login();
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const Divider(color: ColorApp.secondaryColor3, height: 2),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Chưa có tài khoản?', style: FontStyle().noAccountFont),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      'ĐĂNG KÍ',
                      style: FontStyle().registerFont,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

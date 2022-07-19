import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_user_app/main.dart';
import '../../core/authentication/bloc/authentication/authentication_bloc.dart';
import '../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../core/authentication/bloc/authentication/authentication_state.dart';
import '../../theme/validator_text.dart';
import '/widgets/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final bool isRegister;
  const OtpScreen({
    Key? key,
    this.isRegister = false,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final currentRoute = getCurrentRoute();

  String _errorMessage = '';
  final TextEditingController _otpController = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late StreamController<ErrorAnimationType> errorController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    JTToast.init(context);
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColor.primary1,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) async {
          if (state is AuthenticationFailure) {
            _showError(state.errorCode);
          } else if (state is CheckOTPDoneState) {
            if (widget.isRegister) {
              navigateTo(createPasswordRoute);
            } else {
              navigateTo(resetPasswordRoute);
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 65, left: 16, right: 16),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: 155,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.secondary1,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 44,
                          width: 44,
                          color: AppColor.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Center(
                              child: SvgIcon(
                                SvgIcons.arrowBack,
                                color: AppColor.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
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
                onTap: () {
                  if (currentRoute == otpForgotPassWordRoute) {
                    navigateTo(forgotPasswordRoute);
                  } else {
                    navigateTo(registerRoute);
                  }
                },
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
                    Center(
                      child: Text(
                        _errorMessage,
                        style: AppTextTheme.normalHeaderTitle(AppColor.others1),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Form(
                      key: _key,
                      autovalidateMode: _autovalidate,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 60),
                          child: PinCodeTextField(
                            backgroundColor: AppColor.primary1,
                            appContext: context,
                            autoDismissKeyboard: false,
                            pastedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            enablePinAutofill: false,
                            enableActiveFill: false,
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
                            animationDuration:
                                const Duration(milliseconds: 300),
                            textStyle: AppTextTheme.bigText(AppColor.text2),
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                if (_errorMessage.isNotEmpty) {
                                  _errorMessage = '';
                                }
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty || value.trim().isEmpty) {
                                _errorMessage =
                                    ValidatorText.empty(fieldName: 'OTP');
                                return '';
                              } else {
                                _errorMessage = '';
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _otpController.text = value!;
                            },
                            onCompleted: (value) => _checkOTP(),
                          )),
                    ),
                    ButtonLogin(
                      text: 'TIẾP TỤC',
                      login: true,
                      style: AppTextTheme.headerTitle(AppColor.primary1),
                      otp: true,
                      onPressed: _checkOTP,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size(0, 0),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      child: Text(
                        'Gửi lại',
                        style: AppTextTheme.normalHeaderTitle(AppColor.text2),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _checkOTP() {
    setState(() {
      _errorMessage = '';
      AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    });

    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      if (currentRoute == otpForgotPassWordRoute) {
        AuthenticationBlocController().authenticationBloc.add(
              CheckOTPForgot(otp: _otpController.text),
            );
      } else {
        AuthenticationBlocController().authenticationBloc.add(
              CheckOTPRegister(otp: _otpController.text),
            );
      }
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.always;
      });
    }
  }

  _showError(String errorCode) {
    setState(() {
      _errorMessage = showError(errorCode, context);
    });
  }
}

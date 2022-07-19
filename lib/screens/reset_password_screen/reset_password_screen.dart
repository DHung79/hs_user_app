import 'package:flutter/material.dart';
import 'package:hs_user_app/core/authentication/bloc/authentication/authentication_bloc_public.dart';
import 'package:hs_user_app/main.dart';
import 'reset_password_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ResetPasswordScreen> {
  AuthenticationState? state;
  @override
  void initState() {
    JTToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.centerLeft,
      color: AppColor.primary1,
      padding: const EdgeInsets.only(top: 65, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              width: 145,
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
                    'Nhập OTP',
                    style: AppTextTheme.normalText(AppColor.text2),
                  )
                ],
              ),
            ),
            onTap: () {
              navigateTo(otpForgotPassWordRoute);
            },
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đặt mật khẩu mới',
                style: AppTextTheme.bigText(AppColor.text2),
              ),
              const SizedBox(
                height: 24,
              ),
              const ResetPasswordForm(),
              const SizedBox(
                height: 24,
              ),
            ],
          ))
        ],
      ),
    ));
  }
}

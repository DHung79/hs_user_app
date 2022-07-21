import 'package:flutter/material.dart';
import 'package:hs_user_app/core/authentication/bloc/authentication/authentication_bloc_public.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../theme/svg_constants.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.centerLeft,
      color: AppColor.primary1,
      padding: const EdgeInsets.only(top: 42, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 145,
            decoration: BoxDecoration(
                color: AppColor.secondary1,
                borderRadius: BorderRadius.circular(22)),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(otpRoute);
                  },
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: CircleAvatar(
                      backgroundColor: AppColor.text2,
                      child: SvgIcon(
                        SvgIcons.arrowBack,
                        size: 24,
                        color: AppColor.text1,
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
              const CreatePasswordForm(),
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

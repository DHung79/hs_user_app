import 'package:flutter/material.dart';
import 'package:hs_user_app/core/authentication/bloc/authentication/authentication_bloc_public.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import '../../theme/svg_constants.dart';
import 'create_password_form.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  AuthenticationState? state;

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
          Container(
            width: 145,
            decoration: BoxDecoration(
                color: AppColor.text2,
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
                      child: SvgIcon(
                        SvgIcons.arrowBack,
                        color: AppColor.text1,
                        size: 24,
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
                'Tạo mật khẩu mới',
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

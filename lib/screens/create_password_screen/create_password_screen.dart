import 'package:flutter/material.dart';
import 'package:hs_user_app/core/authentication/bloc/authentication/authentication_bloc_public.dart';
import 'package:hs_user_app/main.dart';
import 'create_password_form.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<CreatePasswordScreen> {
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
              navigateTo(otpRegisterRoute);
            },
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tạo mật khẩu',
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

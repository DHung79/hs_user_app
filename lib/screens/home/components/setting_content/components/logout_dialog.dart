import 'package:flutter/material.dart';
import '../../../../../main.dart';

class LogoutDialog extends StatelessWidget {
  final Function()? onPressed;
  const LogoutDialog({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 334,
        constraints: const BoxConstraints(minHeight: 282),
        decoration: BoxDecoration(
          color: AppColor.text2,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'Đăng xuất',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Bạn có chắc chắn muốn đăng xuất?',
                  style: AppTextTheme.normalText(AppColor.text1),
                ),
              ),
              SizedBox(
                height: 52,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.primary2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        SvgIcons.logout,
                        color: AppColor.text2,
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Đăng xuất',
                          style: AppTextTheme.headerTitle(AppColor.text2),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 52,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.shade1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        SvgIcons.arrowBack,
                        color: AppColor.text3,
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Trở về',
                          style: AppTextTheme.headerTitle(AppColor.text3),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

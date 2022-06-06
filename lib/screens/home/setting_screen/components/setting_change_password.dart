import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/screens/layout_template/content_screen.dart';
import 'package:hs_user_app/theme/svg_constants.dart';

import '../../../../core/user/model/user_model.dart';

class SettingChangePassword extends StatefulWidget {
  const SettingChangePassword({Key? key}) : super(key: key);

  @override
  State<SettingChangePassword> createState() => _SettingChangePasswordState();
}

class _SettingChangePasswordState extends State<SettingChangePassword> {
  final PageState _pageState = PageState();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController changePassword = TextEditingController();
  TextEditingController againPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
        future: _pageState.currentUser,
        builder: (context, AsyncSnapshot<UserModel> snapshot) {
          return PageContent(
            child: content(), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Scaffold content() {
    return Scaffold(
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        backgroundColor: AppColor.text2,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        elevation: 16,
        title: Text(
          'Đổi mật khẩu',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
        leading: TextButton(
            onPressed: () {
              navigateTo(settingProfileRoute);
            },
            child: SvgIcon(
              SvgIcons.arrowBack,
              size: 24,
              color: AppColor.text1,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            changpassword(
              name: 'Mật khẩu cũ',
              controller: oldPassword,
            ),
            changpassword(
              name: 'Mật khẩu mới',
              controller: changePassword,
            ),
            changpassword(
              name: 'Nhập lại mật khẩu mới',
              controller: againPassword,
            ),
            confirmbutton()
          ],
        ),
      ),
    );
  }

  SizedBox confirmbutton() {
    return SizedBox(
      height: 52,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(backgroundColor: AppColor.primary2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              SvgIcons.checkCircleOutline,
              size: 24,
              color: AppColor.text2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Xác nhận',
                style: AppTextTheme.headerTitle(AppColor.text2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding changpassword(
      {required String name, required TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              name,
              style: AppTextTheme.mediumHeaderTitle(AppColor.text3),
            ),
          ),
          SizedBox(
            height: 50,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _fetchDataOnPage() {}

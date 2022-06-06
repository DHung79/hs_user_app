import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';

import '../../../../core/user/model/user_model.dart';
import '../../../layout_template/content_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final PageState _pageState = PageState();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
            child: content(context), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Scaffold content(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: Text(
          'Thông tin cá nhân',
          style: AppTextTheme.mediumHeaderTitle(
            AppColor.text1,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          color: AppColor.text1,
          onPressed: () {
            navigateTo(confirmPageRoute);
          },
        ),
      ),
      body: Column(children: [
        inputProfile(
          title: 'Tên',
          controller: nameController,
          color: AppColor.primary1,
        ),
        inputProfile(
          title: 'Địa chỉ',
          controller: addressController,
          color: AppColor.text7,
        ),
        saveButton(
          context,
          name: 'Lưu',
          onPressed: () {},
        ),
      ]),
    );
  }

  Container saveButton(
    BuildContext context, {
    required void Function()? onPressed,
    required String name,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: AppColor.primary2,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(
          name,
          style: AppTextTheme.headerTitle(AppColor.text2),
        ),
      ),
    );
  }

  Padding inputProfile(
      {required String title,
      TextEditingController? controller,
      required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextTheme.normalHeaderTitle(AppColor.text1),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: controller,
            cursorColor: color,
            style: AppTextTheme.normalText(AppColor.text1),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: color, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: color, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: color, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _fetchDataOnPage() {}

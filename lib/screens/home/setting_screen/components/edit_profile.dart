import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/screens/home/setting_screen/components/edit_form.dart';
import 'package:hs_user_app/theme/svg_constants.dart';

import '../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../core/user/bloc/user_bloc.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../widgets/jt_toast.dart';
import '../../../layout_template/content_screen.dart';

class SettingEditProfile extends StatefulWidget {
  const SettingEditProfile({Key? key}) : super(key: key);

  @override
  State<SettingEditProfile> createState() => _SettingEditProfileState();
}

class _SettingEditProfileState extends State<SettingEditProfile> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    JTToast.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

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
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
            child: snapshot.hasData ? content(snapshot) : const SizedBox(),
          );
        },
      ),
    );
  }

  Widget content(AsyncSnapshot<UserModel> snapshot) {  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              navigateTo(profileUserRoute);
            },
            child: SvgIcon(
              SvgIcons.arrowBack,
              color: AppColor.text1,
              size: 24,
            )),
        backgroundColor: AppColor.text2,
        elevation: 16,
        shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
        title: Text(
          'Chỉnh sửa hồ sơ',
          style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
        ),
        centerTitle: true,
      ),
      body: EditForm(editModel:snapshot.data!),
    );
  }


  void _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}

import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';
import 'package:hs_user_app/theme/svg_constants.dart';
import 'package:hs_user_app/theme/validator_text.dart';

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
  String _errorMessage = '';

  TextEditingController namedisplayController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberPhoneController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

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
    final user = snapshot.data;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.text2,
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              navigateTo(settingEditProfileRoute);
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
      body: form(user!),
    );
  }

  Widget form(UserModel user) {
    final editModel = EditUserModel.fromModel(user);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            avatar(),
            inputField(editModel),
            confirmbutton(editModel),
          ],
        ),
      ),
    );
  }

  Widget inputField(EditUserModel editModel) {
    return Form(
      key: _key,
      autovalidateMode: _autovalidate,
      child: Column(
        children: [
          formprofile(
            initialValue: editModel.name,
            color: AppColor.text3,
            name: 'Tên hiển thị',
            hintext: 'Julies Nguyen',
            onSaved: (value) {
              editModel.name = value!.trim();
            },
            onChanged: (value) {
              setState(() {
                if (_errorMessage.isNotEmpty) {
                  _errorMessage = '';
                }
              });
            },
            validator: (value) {
              if (value!.isEmpty || value.trim().isEmpty) {
                return ValidatorText.empty(
                    fieldName: ScreenUtil.t(I18nKey.name)!);
              }
              return null;
            },
          ),
          formprofile(
            initialValue: editModel.email,
            color: AppColor.text3,
            name: 'Email',
            hintext: 'juliesnguyengm@gmail.com',
            onSaved: (value) {
              editModel.name = value!.trim();
            },
            onChanged: (value) {
              setState(() {
                if (_errorMessage.isNotEmpty) {
                  _errorMessage = '';
                }
              });
            },
            validator: (value) {
              if (value!.isEmpty || value.trim().isEmpty) {
                return ValidatorText.empty(
                    fieldName: ScreenUtil.t(I18nKey.email)!);
              }
              return null;
            },
          ),
          formprofile(
            initialValue: editModel.phoneNumber,
            color: AppColor.text7,
            name: 'Số điện thoại',
            hintext: 'juliesnguyengm@gmail.com',
            onSaved: (value) {
              editModel.name = value!.trim();
            },
            onChanged: (value) {
              setState(() {
                if (_errorMessage.isNotEmpty) {
                  _errorMessage = '';
                }
              });
            },
            validator: (value) {
              if (value!.isEmpty || value.trim().isEmpty) {
                return ValidatorText.empty(
                    fieldName: ScreenUtil.t(I18nKey.phoneNumber)!);
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget confirmbutton(EditUserModel editModel) {
    return SizedBox(
      height: 52,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: AppColor.primary2),
        onPressed: () {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            logDebug('confirmbutton');
            _editUserInfo(editModel: editModel);
          } else {
            setState(() {
              _autovalidate = AutovalidateMode.onUserInteraction;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              SvgIcons.checkCircleOutline,
              color: AppColor.text2,
              size: 24,
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

  Padding formprofile(
      {required String name,
      required Color color,
      String? initialValue,
      void Function(String?)? onSaved,
      void Function(String)? onChanged,
      String? Function(String?)? validator,
      TextEditingController? controller,
      required String hintext}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextTheme.mediumHeaderTitle(color),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              onSaved: onSaved,
              onChanged: onChanged,
              validator: validator,
              initialValue: initialValue,
              controller: controller,
              style: AppTextTheme.normalText(AppColor.text7),
              decoration: InputDecoration(
                hintText: hintext,
                hintStyle: AppTextTheme.normalText(AppColor.text7),
                contentPadding: const EdgeInsets.only(left: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.text7, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding avatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 39),
      child: Column(
        children: [
          const SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage(''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: AppColor.text3),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Text(
                  'Tải lên ảnh',
                  style: AppTextTheme.normalText(AppColor.text3),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  _editUserInfo({required EditUserModel editModel}) {
    logDebug(editModel);
    _userBloc.editProfile(editModel: editModel).then(
      (value) async {
        logDebug(value.toJson());
        AuthenticationBlocController().authenticationBloc.add(GetUserData());
        navigateTo(settingProfileRoute);
        JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        logDebug('ssssss');
        setState(() {
          _errorMessage = error.toString();
        });
      },
    );
  }

  void _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}

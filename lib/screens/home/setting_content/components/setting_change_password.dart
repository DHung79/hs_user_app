import 'package:flutter/material.dart';
import '/main.dart';
import '/routes/route_names.dart';
import '/screens/layout_template/content_screen.dart';
import '/theme/svg_constants.dart';
import '../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../core/user/bloc/user_bloc.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../theme/validator_text.dart';
import '../../../../widgets/jt_indicator.dart';
import '../../../../widgets/jt_toast.dart';

class SettingChangePassword extends StatefulWidget {
  const SettingChangePassword({Key? key}) : super(key: key);

  @override
  State<SettingChangePassword> createState() => _SettingChangePasswordState();
}

class _SettingChangePasswordState extends State<SettingChangePassword> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _errorMessage = '';
  TextEditingController oldPassword = TextEditingController();
  TextEditingController changePassword = TextEditingController();
  TextEditingController againPassword = TextEditingController();

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
            child: snapshot.hasData ? content(snapshot) : const JTIndicator(),
          );
        },
      ),
    );
  }

  Widget content(AsyncSnapshot<UserModel> snapshot) {
    final user = snapshot.data;
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
      body: contentChange(user!),
    );
  }

  Widget contentChange(UserModel user) {
    final editModel = EditUserModel.fromModel(user);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _key,
        autovalidateMode: _autovalidate,
        child: Column(
          children: [
            changpassword(
              name: 'Mật khẩu cũ',
              controller: oldPassword,
              onSaved: (value) {
                editModel.password = value!.trim();
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
                  return ValidatorText.empty(fieldName: 'Mật khẩu cũ');
                }
                if (value.trim() != editModel.password) {
                  return 'Nhập sai mật khẩu';
                }
                return null;
              },
            ),
            changpassword(
              name: 'Mật khẩu mới',
              controller: changePassword,
              onChanged: (value) {
                setState(() {
                  if (_errorMessage.isNotEmpty) {
                    _errorMessage = '';
                  }
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return ValidatorText.empty(
                      fieldName: ScreenUtil.t(I18nKey.password)!);
                }
                if (value.length < 6) {
                  return ValidatorText.atLeast(
                      fieldName: ScreenUtil.t(I18nKey.password)!, atLeast: 6);
                }
                if (value.length > 50) {
                  return ValidatorText.moreThan(
                      fieldName: ScreenUtil.t(I18nKey.password)!, moreThan: 50);
                }
                if (value.trim() == editModel.password) {
                  return 'Mật khẩu mới phải khác với mật khẩu cũ';
                }
                return null;
              },
            ),
            changpassword(
              name: 'Nhập lại mật khẩu mới',
              controller: againPassword,
              onSaved: (value) {
                editModel.newPassword = value!.trim();
              },
              onChanged: (value) {
                setState(() {
                  if (_errorMessage.isNotEmpty) {
                    _errorMessage = '';
                  }
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return ValidatorText.empty(
                      fieldName: ScreenUtil.t(I18nKey.password)!);
                }
                if (value != againPassword.text) {
                  return 'Mật khẩu không khớp';
                }
                return null;
              },
            ),
            confirmbutton(editModel)
          ],
        ),
      ),
    );
  }

  SizedBox confirmbutton(EditUserModel editModel) {
    return SizedBox(
      height: 52,
      child: TextButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            _editPassword(editModel: editModel);
          } else {
            setState(() {
              _autovalidate = AutovalidateMode.onUserInteraction;
            });
          }
        },
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

  Padding changpassword({
    required String name,
    required TextEditingController? controller,
    void Function(String)? onChanged,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
  }) {
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
            child: TextFormField(
              onChanged: onChanged,
              onSaved: onSaved,
              validator: validator,
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

  _editPassword({required EditUserModel editModel}) {
    _userBloc.changePassword(editModel: editModel).then(
      (value) async {
        AuthenticationBlocController().authenticationBloc.add(GetUserData());
        navigateTo(profileUserRoute);
        JTToast.successToast(message: ScreenUtil.t(I18nKey.updateSuccess)!);
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        setState(() {
          _errorMessage = error.toString();
        });
      },
    );
  }

  _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}

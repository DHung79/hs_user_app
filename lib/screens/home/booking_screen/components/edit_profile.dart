import 'package:flutter/material.dart';
import 'package:hs_user_app/main.dart';
import 'package:hs_user_app/routes/route_names.dart';

import '../../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../../core/user/bloc/user_bloc.dart';
import '../../../../core/user/model/user_model.dart';
import '../../../../theme/svg_constants.dart';
import '../../../../theme/validator_text.dart';
import '../../../../widgets/jt_toast.dart';
import '../../../layout_template/content_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final PageState _pageState = PageState();
  final _userBloc = UserBloc();
  String _errorMessage = '';
  late EditUserModel _editModel;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final currentRoute = getCurrentRoute();

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
            child: snapshot.hasData
                ? content(snapshot.data)
                : const SizedBox(), // child: content(context),
            pageState: _pageState,
            onFetch: () {
              _fetchDataOnPage();
            },
          );
        },
      ),
    );
  }

  Widget content(UserModel? user) {
    _editModel = EditUserModel.fromModel(user);
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
        leading: TextButton(
          child: SvgIcon(SvgIcons.arrowBack),
          onPressed: () {
            if (currentRoute == editPostFastRoute) {
              navigateTo(postFastRoute);
            } else {
              navigateTo(confirmRoute);
            }
          },
        ),
      ),
      body: Form(
        key: _key,
        autovalidateMode: _autovalidate,
        child: Column(children: [
          inputProfile(
            title: 'Tên',
            initialValue: _editModel.name,
            onSaved: (value) {
              _editModel.name = value!.trim();
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
          inputProfile(
            title: 'Số điện thoại',
            keyboardType: TextInputType.number,
            initialValue: _editModel.phoneNumber,
            onSaved: (value) {
              _editModel.phoneNumber = value!.trim();
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
          saveButton(
            context,
            name: 'Lưu',
            onPressed: () {
              if (_key.currentState!.validate()) {
                _key.currentState!.save();
                logDebug('confirmbutton');
                _editUserInfo();
              } else {
                setState(() {
                  _autovalidate = AutovalidateMode.onUserInteraction;
                });
              }
            },
          ),
        ]),
      ),
    );
  }

  _editUserInfo() {
    logDebug(_editModel.address);
    _userBloc.editProfile(editModel: _editModel).then(
      (value) async {
        AuthenticationBlocController().authenticationBloc.add(GetUserData());
        if (currentRoute == editPostFastRoute) {
          navigateTo(postFastRoute);
        } else {
          navigateTo(confirmRoute);
        }
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
      String? initialValue,
      void Function(String)? onChanged,
      void Function(String?)? onSaved,
      TextInputType? keyboardType,
      String? Function(String?)? validator}) {
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
          TextFormField(
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            cursorColor: AppColor.text3,
            style: AppTextTheme.normalText(AppColor.text1),
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
                borderSide: BorderSide(color: AppColor.primary1, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _fetchDataOnPage() {
    _userBloc.getProfile();
  }
}

import 'package:flutter/material.dart';
import 'components.dart';

class EditUserInfo extends StatefulWidget {
  final UserBloc userBloc;
  final EditUserModel editUserModel;
  final Function(UserModel?) goBack;
  const EditUserInfo({
    Key? key,
    required this.editUserModel,
    required this.userBloc,
    required this.goBack,
  }) : super(key: key);

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  final _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.shadow.withOpacity(0.16),
                blurRadius: 16,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(minHeight: 56, maxWidth: 40),
                color: AppColor.transparent,
                highlightColor: AppColor.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgIcon(
                    SvgIcons.arrowBack,
                    size: 24,
                    color: AppColor.black,
                  ),
                ),
                onPressed: () {
                  widget.goBack(null);
                },
              ),
              Center(
                child: Text(
                  'Thông tin cá nhân',
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
                ),
              ),
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(maxWidth: 40),
                color: Colors.transparent,
                highlightColor: AppColor.white,
                child: const SizedBox(),
              ),
            ],
          ),
        ),
        Form(
          key: _key,
          autovalidateMode: _autovalidate,
          child: Column(
            children: [
              _buildInput(
                title: 'Tên',
                initialValue: widget.editUserModel.name,
                onSaved: (value) {
                  widget.editUserModel.name = value!.trim();
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
              _buildInput(
                title: 'Số điện thoại',
                keyboardType: TextInputType.number,
                initialValue: widget.editUserModel.phoneNumber,
                onSaved: (value) {
                  widget.editUserModel.phoneNumber = value!.trim();
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
                  String pattern =
                      r'^(\+843|\+845|\+847|\+848|\+849|\+841|03|05|07|08|09|01[2|6|8|9])+([0-9]{8})$';
                  RegExp regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
                    return ScreenUtil.t(I18nKey.invalidPhoneNumber)!;
                  }
                  return null;
                },
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Text(
                      _errorMessage,
                      style: AppTextTheme.normalHeaderTitle(AppColor.others1),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppButtonTheme.fillRounded(
                  constraints: const BoxConstraints(minHeight: 52),
                  color: AppColor.primary2,
                  borderRadius: BorderRadius.circular(4),
                  child: Center(
                    child: Text(
                      'Lưu',
                      style: AppTextTheme.headerTitle(AppColor.text2),
                    ),
                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      _editUserInfo();
                    } else {
                      setState(() {
                        _autovalidate = AutovalidateMode.onUserInteraction;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInput({
    required String title,
    required String initialValue,
    Function(String)? onChanged,
    Function(String?)? onSaved,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
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
            style: AppTextTheme.normalText(AppColor.text1),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColor.text7,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColor.primary1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _editUserInfo() {
    widget.userBloc.editProfile(editModel: widget.editUserModel).then(
      (value) async {
        widget.goBack(value);
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        logDebug(error.toString());
      },
    );
  }
}

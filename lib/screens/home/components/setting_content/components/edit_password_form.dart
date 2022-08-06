import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../core/user/user.dart';
import '../../../../../main.dart';
import '../../../../../theme/validator_text.dart';
import '../../../../../widgets/error_message.dart';

class EditPasswordForm extends StatefulWidget {
  final UserModel user;
  const EditPasswordForm({Key? key, required this.user}) : super(key: key);

  @override
  State<EditPasswordForm> createState() => _EditPasswordFormState();
}

class _EditPasswordFormState extends State<EditPasswordForm> {
  String _errorMessage = '';
  late EditUserModel _editModel;
  final _userBloc = UserBloc();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _checkNewPassword = TextEditingController();
  bool _oldPasswordSecure = true;
  bool _newPasswordSecure = true;
  bool _checkNewPasswordSecure = true;

  @override
  void initState() {
    JTToast.init(context);
    _editModel = EditUserModel.fromModel(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode: _autovalidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: inputField(),
          ),
          ErrorMessage(errorMessage: _errorMessage),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: _actions(),
          ),
        ],
      ),
    );
  }

  Widget inputField() {
    return Wrap(
      runSpacing: 24,
      children: [
        _buildInput(
          name: 'Mật khẩu cũ',
          hintText: 'Nhập mật khẩu cũ',
          controller: _currentPassword,
          obscureText: _oldPasswordSecure,
          passwordIconOnPressed: () {
            setState(() {
              _oldPasswordSecure = !_oldPasswordSecure;
            });
          },
          onSaved: (value) {
            _editModel.password = value!.trim();
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
            return null;
          },
        ),
        _buildInput(
          controller: _newPassword,
          name: 'Mật khẩu mới',
          hintText: 'Nhập mật khẩu mới',
          obscureText: _newPasswordSecure,
          passwordIconOnPressed: () {
            setState(() {
              _newPasswordSecure = !_newPasswordSecure;
            });
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
            if (value.length < 6) {
              return ValidatorText.atLeast(
                  fieldName: ScreenUtil.t(I18nKey.password)!, atLeast: 6);
            }
            if (value.length > 50) {
              return ValidatorText.moreThan(
                  fieldName: ScreenUtil.t(I18nKey.password)!, moreThan: 50);
            }
            return null;
          },
        ),
        _buildInput(
          controller: _checkNewPassword,
          name: 'Nhập lại mật khẩu mới',
          hintText: 'Nhập lại mật khẩu mới',
          obscureText: _checkNewPasswordSecure,
          passwordIconOnPressed: () {
            setState(() {
              _checkNewPasswordSecure = !_checkNewPasswordSecure;
            });
          },
          onSaved: (value) {
            _editModel.newPassword = value!.trim();
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
            if (value != _newPassword.text) {
              return 'Mật khẩu không khớp';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildInput({
    required String name,
    String? hintText,
    TextEditingController? controller,
    String? initialValue,
    bool obscureText = false,
    Function()? passwordIconOnPressed,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextTheme.mediumHeaderTitle(AppColor.text3),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 50),
          margin: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            controller: controller,
            initialValue: initialValue,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: AppTextTheme.normalText(AppColor.text3),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextTheme.normalText(AppColor.text7),
              contentPadding: const EdgeInsets.only(left: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.text7),
                borderRadius: BorderRadius.circular(4),
              ),
              // suffixIcon: TextButton(
              //   child: obscureText
              //       ? SvgIcon(
              //           SvgIcons.removeRedEye,
              //           color: AppColor.black,
              //         )
              //       : SvgIcon(
              //           SvgIcons.eyeOff,
              //           color: AppColor.black,
              //         ),
              //   onPressed: passwordIconOnPressed,
              // ),
            ),
            onSaved: onSaved,
            onChanged: onChanged,
            validator: validator,
          ),
        )
      ],
    );
  }

  Widget _actions() {
    return SizedBox(
      height: 52,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: AppColor.primary2),
        onPressed: () {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            _editUserPassword();
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

  _editUserPassword() {
    _userBloc.changePassword(editModel: _editModel).then(
      (value) async {
        AuthenticationBlocController().authenticationBloc.add(UserLogOut());
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        logDebug('error: ${error.toString()}');
      },
    );
  }
}

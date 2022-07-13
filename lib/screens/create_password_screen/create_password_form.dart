import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/validator_text.dart';
import '../../widgets/jt_text_form_field.dart';

class CreatePasswordForm extends StatefulWidget {
  final AuthenticationState? state;
  const CreatePasswordForm({Key? key, this.state}) : super(key: key);
  @override
  _CreatePasswordFormState createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends State<CreatePasswordForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final setPasswordController = TextEditingController();
  String? _errorMessage = '';
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  bool _newPasswordSecure = true;
  bool _checkNewPasswordSecure = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) async {
          if (state is AuthenticationFailure) {
            _showError(state.errorCode);
          } else if (state is ResetPasswordDoneState) {
            navigateTo(authenticationRoute);
          }
        },
        child: LayoutBuilder(
          builder: (context, size) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: size.maxWidth < 500
                  ? EdgeInsets.zero
                  : const EdgeInsets.all(30),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: size.maxWidth),
                  child: Column(
                    children: [
                      _buildErrorMessage(),
                      Form(
                        autovalidateMode: _autovalidate,
                        key: _key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildErrorMessage(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: JTTextFormField(
                                hintText: 'NHẬP MẬT KHẨU MỚI',
                                controller: passwordController,
                                passwordIconOnPressed: () {
                                  setState(() {
                                    _newPasswordSecure = !_newPasswordSecure;
                                  });
                                },
                                onSaved: (value) {
                                  passwordController.text = value!.trim();
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if (_errorMessage!.isNotEmpty) {
                                      _errorMessage = '';
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ValidatorText.empty(
                                        fieldName:
                                            ScreenUtil.t(I18nKey.password)!);
                                  }
                                  if (value.length < 6) {
                                    return ValidatorText.atLeast(
                                        fieldName:
                                            ScreenUtil.t(I18nKey.password)!,
                                        atLeast: 6);
                                  }
                                  if (value.length > 50) {
                                    return ValidatorText.moreThan(
                                        fieldName:
                                            ScreenUtil.t(I18nKey.password)!,
                                        moreThan: 50);
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: JTTextFormField(
                                hintText: 'NHẬP LẠI',
                                controller: setPasswordController,
                                passwordIconOnPressed: () {
                                  setState(() {
                                    _checkNewPasswordSecure =
                                        !_checkNewPasswordSecure;
                                  });
                                },
                                onSaved: (value) {
                                  setPasswordController.text = value!.trim();
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if (_errorMessage!.isNotEmpty) {
                                      _errorMessage = '';
                                    }
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ValidatorText.empty(
                                        fieldName:
                                            ScreenUtil.t(I18nKey.password)!);
                                  }
                                  if (value != passwordController.text) {
                                    return 'Mật khẩu không khớp';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: const Size.fromHeight(52),
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  'XÁC NHẬN',
                                  style: AppTextTheme.headerTitle(
                                      AppColor.primary1),
                                ),
                                onPressed: () => _forgotPassword(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  _forgotPassword() {
    setState(() {
      _errorMessage = '';
    });
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            UserSignUp(
              password: setPasswordController.text,
            ),
          );
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.always;
      });
    }
  }

  _buildErrorMessage() {
    return _errorMessage != null && _errorMessage!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 24,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: Theme.of(context).errorColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  child: Text(
                    _errorMessage!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).errorColor),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  _showError(String errorCode) async {
    setState(() {
      _errorMessage = showError(errorCode, context);
    });
  }
}

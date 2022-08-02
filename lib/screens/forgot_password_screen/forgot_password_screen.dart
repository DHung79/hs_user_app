import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/validator_text.dart';
import '../../widgets/jt_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  // bool _passwordSecure = true;
  String? _errorMessage = '';
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColor.primary1,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) async {
          if (state is AuthenticationFailure) {
            _showError(state.errorCode);
          }
          if (state is ForgotPasswordDoneState) {
            navigateTo(otpForgotPassWordRoute);
          }
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, size) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: size.maxWidth < 500
                    ? EdgeInsets.zero
                    : const EdgeInsets.all(30),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: size.maxWidth - 32),
                      child: Form(
                        autovalidateMode: _autovalidate,
                        key: _key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                navigateTo(authenticationRoute);
                              },
                              child: ClipOval(
                                child: Container(
                                  height: 44,
                                  width: 44,
                                  color: AppColor.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgIcon(
                                      SvgIcons.close,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    ScreenUtil.t(I18nKey.forgotPassword)!,
                                    style: AppTextTheme.bigText(Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Center(
                                    child: Text(
                                      _errorMessage!,
                                      style: AppTextTheme.normalHeaderTitle(
                                          AppColor.others1),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: JTTextFormField(
                                    hintText: 'NHẬP EMAIL',
                                    keyboardType: TextInputType.emailAddress,
                                    controller: forgotPasswordEmailController,
                                    onSaved: (value) {
                                      forgotPasswordEmailController.text =
                                          value!.trim();
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        if (_errorMessage!.isNotEmpty) {
                                          _errorMessage = '';
                                        }
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          value.trim().isEmpty) {
                                        return ValidatorText.empty(
                                            fieldName:
                                                ScreenUtil.t(I18nKey.email)!);
                                      }
                                      if (!isEmail(value.trim())) {
                                        return ValidatorText.invalidFormat(
                                            fieldName:
                                                ScreenUtil.t(I18nKey.email)!);
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size.fromHeight(52),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'TIẾP TỤC',
                                      style: AppTextTheme.headerTitle(
                                          AppColor.primary1),
                                    ),
                                    onPressed: _forgotPassword,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _forgotPassword() {
    setState(() {
      _errorMessage = '';
    });
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            ForgotPassword(email: forgotPasswordEmailController.text),
          );
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  _showError(String errorCode) async {
    setState(() {
      _errorMessage = showError(errorCode, context);
    });
  }
}

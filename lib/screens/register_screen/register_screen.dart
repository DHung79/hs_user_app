import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_user_app/theme/svg_constants.dart';
import '/routes/route_names.dart';
import 'package:validators/validators.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/validator_text.dart';
import '../../widgets/jt_text_form_field.dart';
import '../../widgets/jt_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
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
            } else if (state is CheckEmailDoneState) {
              JTToast.init(context);
              navigateTo(otpRegisterRoute);
              await Future.delayed(const Duration(milliseconds: 400));
              JTToast.successToast(
                  width: 327,
                  height: 53,
                  message: ScreenUtil.t(I18nKey.checkYourEmail)!);
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
                    child: Container(
                      constraints: BoxConstraints(maxWidth: size.maxWidth - 32),
                      child: Form(
                        autovalidateMode: _autovalidate,
                        key: _key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: InkWell(
                                onTap: () {
                                  navigateTo(authenticationRoute);
                                },
                                child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: SvgIcon(
                                      SvgIcons.close,
                                      size: 24,
                                      color: AppColor.text1,
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
                                    'Đăng kí',
                                    style: AppTextTheme.bigText(Colors.white),
                                  ),
                                ),
                                _buildErrorMessage(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: JTTextFormField(
                                    hintText: 'NHẬP EMAIL',
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    onSaved: (value) {
                                      emailController.text = value!.trim();
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
                                    onPressed: () {
                                      _register();
                                    },
                                    // onPressed: () {},
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
                );
              },
            ),
          ),
        ));
  }

  _register() {
    setState(() {
      _errorMessage = '';
      loginGoogle = false;
    });

    
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            CheckEmail(
              email: emailController.text,
            ),
          );
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

Widget _buildErrorMessage() {
    return _errorMessage != null && _errorMessage!.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Center(
              child: Text(
                _errorMessage!,
                style: AppTextTheme.normalHeaderTitle(AppColor.others1),
              ),
            ),
          )
        : const SizedBox();
  }

  _showError(String errorCode) async {
    setState(() {
      _errorMessage = showError(errorCode, context);
      logDebug(_errorMessage);
    });
  }
}

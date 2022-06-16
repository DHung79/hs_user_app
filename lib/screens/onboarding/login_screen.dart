import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../widgets/button_widget.dart';
import '/routes/route_names.dart';
import 'package:validators/validators.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/validator_text.dart';
import '../../widgets/jt_text_form_field.dart';

class LoginForm extends StatefulWidget {
  final AuthenticationState? state;
  const LoginForm({Key? key, this.state}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // bool _passwordSecure = true;
  String? _errorMessage = '';
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  bool? _isKeepSession = false;
  bool _passwordSecure = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(GetLastUser());
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {});
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: AuthenticationBlocController().authenticationBloc,
      listener: (context, state) {
        logDebug(state);

        if (state is AuthenticationFailure) {
          _showError(state.errorCode);
        } else if (state is LoginLastUser) {
          emailController.text = state.username;
          setState(() {
            _isKeepSession = state.isKeepSession;
          });
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
                constraints: BoxConstraints(maxWidth: size.maxWidth - 32),
                child: Form(
                  autovalidateMode: _autovalidate,
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildErrorMessage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: JTTextFormField(
                          hintText: 'TÀI KHOẢN',
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
                            if (value!.isEmpty || value.trim().isEmpty) {
                              return ValidatorText.empty(
                                  fieldName: ScreenUtil.t(I18nKey.email)!);
                            }
                            if (!isEmail(value.trim())) {
                              return ValidatorText.invalidFormat(
                                  fieldName: ScreenUtil.t(I18nKey.email)!);
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: JTTextFormField(
                          hintText: 'MẬT KHẨU',
                          isPassword: true,
                          obscureText: _passwordSecure,
                          controller: passwordController,
                          passwordIconOnPressed: () {
                            setState(() {
                              _passwordSecure = !_passwordSecure;
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
                                  fieldName: ScreenUtil.t(I18nKey.password)!);
                            }
                            if (value.length < 6) {
                              return ValidatorText.atLeast(
                                  fieldName: ScreenUtil.t(I18nKey.password)!,
                                  atLeast: 6);
                            }
                            if (value.length > 50) {
                              return ValidatorText.moreThan(
                                  fieldName: ScreenUtil.t(I18nKey.password)!,
                                  moreThan: 50);
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 18),
                          child: InkWell(
                            child: Text(
                              ScreenUtil.t(I18nKey.forgotPassword)!,
                              style: AppTextTheme.link(Colors.white),
                            ),
                            onTap: () => navigateTo(forgotPasswordRoute),
                          ),
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
                            ScreenUtil.t(I18nKey.signIn)!.toUpperCase(),
                            style: AppTextTheme.headerTitle(AppColor.primary1),
                          ),
                          onPressed: () => _login(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ButtonLogin(
                          otp: false,
                          onPressed: _loginGoogle,
                          login: false,
                          text: 'ĐĂNG NHẬP VỚI GOOGLE',
                          style: AppTextTheme.headerTitle(AppColor.secondary2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Divider(
                          height: 1,
                          color: AppColor.secondary1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bạn chưa có tài khoản?',
                              style:
                                  AppTextTheme.headerTitle(AppColor.secondary3),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(registerRoute);
                              },
                              child: Text(
                                'Đăng Kí',
                                style: AppTextTheme.headerTitle(AppColor.text2),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  _loginGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    setState(() {
      _errorMessage = '';
      loginGoogle = true;
    });

    AuthenticationBlocController().authenticationBloc.add(
          UserLoginGoogle(
            keepSession: _isKeepSession!,
            accessToken: googleAuth.accessToken!,
            isMobile: true,
          ),
        );
  }

  _login() {
    setState(() {
      _errorMessage = '';
      loginGoogle = false;
    });
    if (widget.state is AuthenticationLoading) return;

    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            UserLogin(
              email: emailController.text,
              password: passwordController.text,
              keepSession: _isKeepSession!,
              isMobile: true,
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
    });
  }
}

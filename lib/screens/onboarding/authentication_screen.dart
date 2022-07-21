import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/svg_constants.dart';
import '/routes/route_names.dart';
import '../../../main.dart';
import '../../core/authentication/auth.dart';
import 'login_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _currentRoute = getCurrentRoute();
  bool _isLoading = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      _isLoading = true;
    });

    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    logDebug(_currentRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primary1,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) {
          if (state is AppAutheticated) {
            navigateTo(homeRoute);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: AuthenticationBlocController().authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            return SafeArea(
              child: LayoutBuilder(builder: (context, size) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.maxHeight / 5,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    LoginForm(state: state),
                    const SizedBox(
                      height: 47,
                    ),
                    if (_isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 92,
                          decoration: BoxDecoration(
                            color: AppColor.text2,
                            gradient: LinearGradient(
                                stops: const [0.031, 0.02],
                                colors: [AppColor.shade9, Colors.white]),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Đăng kí thành công',
                                          style: AppTextTheme.mediumHeaderTitle(
                                              AppColor.primary1),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Giờ đây bạn có thể đăng nhập với tài khoản vừa tạo',
                                          style: AppTextTheme.normalText(
                                              AppColor.text3),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Container(
                                      width: 1,
                                      color: AppColor.shade1,
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLoading = !_isLoading;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: const Size(0, 0),
                                      ),
                                      child: SvgIcon(
                                        SvgIcons.close,
                                        size: 24,
                                        color: AppColor.text1,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }

  // String _getLanguage() {
  //   switch (App.of(context)!.currentLocale.languageCode) {
  //     case 'vi':
  //       return 'Tiếng Việt';
  //     case 'en':
  //       return 'English';
  //     case 'th':
  //       return 'Thai';
  //     default:
  //       return 'Tiếng Việt';
  //   }
  // }
}

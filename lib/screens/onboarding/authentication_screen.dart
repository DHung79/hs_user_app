import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import '../../core/authentication/auth.dart';
import 'login_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
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
            return LayoutBuilder(builder: (context, size) {
              final screenSize = MediaQuery.of(context).size;
              final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
              return SizedBox(
                height: screenSize.height - bottomHeight,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.maxHeight / 3,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      LoginForm(state: state),
                    ],
                  ),
                ),
              );
            });
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

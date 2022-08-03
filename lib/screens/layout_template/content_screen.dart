import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_user_app/config/fcm/fcm.dart';
import '../../core/user/bloc/user_bloc.dart';
import '../../core/user/model/user_model.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/validator_text.dart';

class PageTemplate extends StatefulWidget {
  final Widget child;
  final PageState? pageState;
  final void Function(UserModel?) onUserFetched;
  final Widget? navItem;
  final Widget? tabTitle;
  final int? currentTab;
  final Widget? leading;
  final Widget? drawer;
  final List<Widget>? actions;
  final double elevation;
  final double appBarHeight;
  final Widget? flexibleSpace;
  final bool showAppBar;
  final void Function() onFetch;
  final Widget? appBar;

  const PageTemplate({
    Key? key,
    required this.child,
    this.pageState,
    required this.onUserFetched,
    this.navItem,
    this.tabTitle,
    this.currentTab,
    this.leading,
    this.drawer,
    this.actions,
    this.elevation = 0,
    this.appBarHeight = 56,
    this.flexibleSpace,
    this.showAppBar = true,
    required this.onFetch,
    this.appBar,
  }) : super(key: key);

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  late AuthenticationBloc _authenticationBloc;
  Future<UserModel>? _currentUser;
// int _totalNotifications;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool showNoti = false;
  final _userBloc = UserBloc();
  PushNotification? _notificationInfo;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBlocController().authenticationBloc;
    _authenticationBloc.add(AppLoadedup());
    requestPermissionsLocal();
    registerNotification(
      getFcmToken: (fcmToken) {
        currentFcmToken = fcmToken;
      },
      notificationInfo: _notificationInfo,
      onMessage: widget.onFetch,
    );
    checkForInitialMessage(getNotification: (notification) {
      setState(() {
        _notificationInfo = notification;
      });
    });
    initLocalPushNotification();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.title,
        dataTitle: message.data['title'].toString(),
        dataBody: message.data['body'].toString(),
      );
      setState(() {
        _notificationInfo = notification;
      });
    });
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
    JTToast.init(context);
    return WillPopScope(
      onWillPop: () async {
        final listPageCanPop = [
          initialRoute,
          authenticationRoute,
          homeRoute,
        ];
        final listTabCanPop = [
          bookTaskRoute,
          settingRoute,
          notificationRoute,
        ];
        final currentRoute = getCurrentRoute();
        if (preRoute.isNotEmpty && !listPageCanPop.contains(currentRoute)) {
          if (listTabCanPop.contains(currentRoute)) {
            navigateTo(homeRoute);
          } else {
            navigateTo(preRoute);
          }
        }
        return false;
      },
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: _authenticationBloc,
        listener: (BuildContext context, AuthenticationState state) async {
          if (state is AuthenticationStart) {
            navigateTo(authenticationRoute);
          } else if (state is UserLogoutState) {
            if (preRoute == userProfileRoute) {
              JTToast.successToast(
                message: 'Đổi mật khẩu thành công, đăng nhập lại để sử dụng',
              );
            }
            navigateTo(authenticationRoute);
          } else if (state is AuthenticationFailure) {
            _showError(state.errorCode);
          } else if (state is UserTokenExpired) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  ScreenUtil.t(I18nKey.signInSessionExpired)!,
                ),
              ),
            );
            navigateTo(authenticationRoute);
          } else if (state is AppAutheticated) {
            _authenticationBloc.add(GetUserData());
          } else if (state is SetUserData<UserModel>) {
            setState(() {
              _currentUser = Future.value(state.currentUser);
            });
          }
        },
        child: StreamBuilder(
          stream: _currentUser?.asStream(),
          builder: (context, snapshot) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              key: _key,
              backgroundColor: Colors.white,
              appBar: widget.showAppBar
                  ? PreferredSize(
                      preferredSize: Size.fromHeight(widget.appBarHeight),
                      child: widget.appBar ??
                          AppBar(
                            backgroundColor: Colors.white,
                            flexibleSpace: widget.flexibleSpace,
                            centerTitle: widget.currentTab != 0,
                            leading: widget.leading,
                            actions: widget.actions,
                            title: widget.tabTitle,
                            elevation: widget.elevation,
                          ),
                    )
                  : null,
              drawer: widget.drawer,
              bottomNavigationBar: widget.navItem,
              body: LayoutBuilder(
                builder: (context, size) {
                  return BlocListener<AuthenticationBloc, AuthenticationState>(
                    bloc: AuthenticationBlocController().authenticationBloc,
                    listener:
                        (BuildContext context, AuthenticationState state) {
                      if (state is SetUserData<UserModel>) {
                        // App.of(context)!.setLocale(
                        //   supportedLocales.firstWhere(
                        //       (e) => e.languageCode == state.currentLang),
                        // );
                        setState(() {
                          widget.pageState!.currentUser = Future.value(
                            state.currentUser,
                          );
                          widget.onUserFetched(state.currentUser);
                        });
                      }
                    },
                    child: widget.child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  _showError(String errorCode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(showError(errorCode, context))),
    );
  }
}

class PageContent extends StatelessWidget {
  final PageState pageState;
  final void Function()? onFetch;
  final Widget child;

  const PageContent({
    Key? key,
    required this.pageState,
    required this.child,
    this.onFetch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!pageState.isInitData) {
      if (onFetch != null) onFetch!();
      pageState.isInitData = true;
    }
    return child;
  }
}

class PageState {
  bool isInitData = false;
  Future<UserModel>? currentUser;
}

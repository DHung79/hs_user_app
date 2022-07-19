import 'route_names.dart';

class AppRoutePath {
  final String? name;
  final String routeId;
  final bool isUnknown;

  AppRoutePath.initial()
      : name = initialRoute,
        routeId = '',
        isUnknown = false;
  //authentication
  AppRoutePath.authentication()
      : name = authenticationRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.register()
      : name = registerRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.otpRegister()
      : name = otpRegisterRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.createPassword()
      : name = createPasswordRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.forgotPassword()
      : name = forgotPasswordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.otpForgotPassword()
      : name = otpForgotPassWordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.resetPassword()
      : name = resetPasswordRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.home()
      : name = homeRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.bookTask()
      : name = bookTaskRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.bookNewTask()
      : name = bookNewTaskRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.rebookTask(String id)
      : name = rebookTaskRoute + id,
        routeId = '',
        isUnknown = false;
  AppRoutePath.taskBooked(String id)
      : name = taskBookedRoute + id,
        routeId = '',
        isUnknown = false;
  AppRoutePath.taskHistory(String id)
      : name = taskHistoryRoute + id,
        routeId = '',
        isUnknown = false;

  AppRoutePath.setting()
      : name = settingRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.userProfile()
      : name = userProfileRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.editProfile()
      : name = editProfileRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.userChangePassword()
      : name = userChangePasswordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.payment()
      : name = paymentRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.promotion()
      : name = promotionRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.notification()
      : name = notificationRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.unknown()
      : name = null,
        routeId = '',
        isUnknown = true;

  static AppRoutePath routeFrom(String? name) {
    if (name == initialRoute) {
      return AppRoutePath.initial();
    }
    //authentication
    if (name == authenticationRoute) {
      return AppRoutePath.authentication();
    }

    if (name == registerRoute) {
      return AppRoutePath.register();
    }
    if (name == otpRegisterRoute) {
      return AppRoutePath.otpRegister();
    }
    if (name == createPasswordRoute) {
      return AppRoutePath.createPassword();
    }

    if (name == forgotPasswordRoute) {
      return AppRoutePath.forgotPassword();
    }
    if (name == otpForgotPassWordRoute) {
      return AppRoutePath.otpForgotPassword();
    }
    if (name == resetPasswordRoute) {
      return AppRoutePath.resetPassword();
    }

    if (name == homeRoute) {
      return AppRoutePath.home();
    }

    if (name == bookTaskRoute) {
      return AppRoutePath.bookTask();
    }
    if (name != null && name.startsWith(rebookTaskRoute)) {
      if (name.length > rebookTaskRoute.length) {
        final id = name.substring(rebookTaskRoute.length + 1, name.length);
        if (id.isNotEmpty) return AppRoutePath.rebookTask(id);
      }
      return AppRoutePath.bookTask();
    }
    if (name != null && name.startsWith(rebookTaskRoute)) {
      if (name.length > rebookTaskRoute.length) {
        final id = name.substring(rebookTaskRoute.length + 1, name.length);
        if (id.isNotEmpty) return AppRoutePath.taskBooked(id);
      }
      return AppRoutePath.bookTask();
    }
    if (name != null && name.startsWith(rebookTaskRoute)) {
      if (name.length > rebookTaskRoute.length) {
        final id = name.substring(rebookTaskRoute.length + 1, name.length);
        if (id.isNotEmpty) return AppRoutePath.taskHistory(id);
      }
      return AppRoutePath.bookTask();
    }

    if (name == settingRoute) {
      return AppRoutePath.setting();
    }
    if (name == userProfileRoute) {
      return AppRoutePath.userProfile();
    }
    if (name == editProfileRoute) {
      return AppRoutePath.editProfile();
    }
    if (name == userChangePasswordRoute) {
      return AppRoutePath.userChangePassword();
    }
    if (name == paymentRoute) {
      return AppRoutePath.payment();
    }

    if (name == notificationRoute) {
      return AppRoutePath.notification();
    }
    if (name == promotionRoute) {
      return AppRoutePath.promotion();
    }

    return AppRoutePath.unknown();
  }
}

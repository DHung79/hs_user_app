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

  AppRoutePath.home()
      : name = homeRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.booking()
      : name = bookingRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.notification()
      : name = notificationRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.posttask()
      : name = bookNewTaskRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.profileTasker()
      : name = profileTaskersRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.gpsPage()
      : name = gpsPageRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.chooseLocation()
      : name = gpsPageRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.taskHistory()
      : name = gpsPageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.confirm()
      : name = confirmRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.editProfile()
      : name = editProfileRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.viewDetail()
      : name = taskBookedRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.postFast()
      : name = rebookTaskRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.settingProfile()
      : name = userProfileRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.otpRegister()
      : name = otpRegisterRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.setting()
      : name = settingRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.otpForgotPassword()
      : name = otpForgotPassWordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.editPostFast()
      : name = editPostFastRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editConfirm()
      : name = editConfirmRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.settingChangePassword()
      : name = userChangePasswordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.createPassword()
      : name = createPasswordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.resetPassword()
      : name = resetPasswordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.payment()
      : name = paymentRoute,
        routeId = '',
        isUnknown = false;
      

  AppRoutePath.forgotPassword()
      : name = forgotPasswordRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.settingEditProfile()
      : name = editProfileRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.promotion()
      : name = promotionRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.editTaskProfile()
      : name = editTaskProfileRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.profileUser()
      : name = profileUserRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.register()
      : name = registerRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.otp()
      : name = otpRoute,
        routeId = '',
        isUnknown = false;
          AppRoutePath.pickTypeHome()
      : name = pickTypeHomeRoute,
        routeId = '',
        isUnknown = false;
  // AppRoutePath.roles()
  //     : name = roleRoute,
  //       routeId = '',
  //       isUnknown = false;
  // AppRoutePath.createRoles()
  //     : name = createRoleRoute,
  //       routeId = '',
  //       isUnknown = false;
  // AppRoutePath.editRoles(String id)
  //     : name = editRoleRoute + id,
  //       routeId = '',
  //       isUnknown = false;

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
    if (name == homeRoute) {
      return AppRoutePath.home();
    }
    if (name == taskHistoryRoute) {
      return AppRoutePath.taskHistory();
    }
    if (name == userProfileRoute) {
      return AppRoutePath.settingProfile();
    }

    if (name == createPasswordRoute) {
      return AppRoutePath.createPassword();
    }
    if (name == resetPasswordRoute) {
      return AppRoutePath.resetPassword();
    }

    if (name == profileUserRoute) {
      return AppRoutePath.profileUser();
    }
    if (name == rebookTaskRoute) {
      return AppRoutePath.postFast();
    }
    if (name == paymentRoute) {
      return AppRoutePath.payment();
    }
    if (name == otpForgotPassWordRoute) {
      return AppRoutePath.otpForgotPassword();
    }
    if (name == otpRegisterRoute) {
      return AppRoutePath.otpRegister();
    }
    if (name == editPostFastRoute) {
      return AppRoutePath.editPostFast();
    }
    if (name == editConfirmRoute) {
      return AppRoutePath.editConfirm();
    }
    if (name == settingRoute) {
      return AppRoutePath.setting();
    }
    if (name == promotionRoute) {
      return AppRoutePath.promotion();
    }
    if (name == editProfileRoute) {
      return AppRoutePath.settingEditProfile();
    }
    if (name == userChangePasswordRoute) {
      return AppRoutePath.settingChangePassword();
    }
    if (name == notificationRoute) {
      return AppRoutePath.notification();
    }
    if (name == profileTaskersRoute) {
      return AppRoutePath.profileTasker();
    }

    if (name == gpsPageRoute) {
      return AppRoutePath.gpsPage();
    }
    if (name == editTaskProfileRoute) {
      return AppRoutePath.editTaskProfile();
    }

    if (name == chooseLocationRoute) {
      return AppRoutePath.chooseLocation();
    }

    if (name == bookingRoute) {
      return AppRoutePath.booking();
    }
    if (name == bookNewTaskRoute) {
      return AppRoutePath.posttask();
    }
    if (name == confirmRoute) {
      return AppRoutePath.confirm();
    }
    if (name == editProfileRoute) {
      return AppRoutePath.editProfile();
    }

    if (name == taskBookedRoute) {
      return AppRoutePath.viewDetail();
    }

    if (name == forgotPasswordRoute) {
      return AppRoutePath.forgotPassword();
    }

    if (name == registerRoute) {
      return AppRoutePath.register();
    }

    if (name == otpRoute) {
      return AppRoutePath.otp();
    }
    if (name == pickTypeHomeRoute) {
      return AppRoutePath.pickTypeHome();
    }
    // if (name == roleRoute) {
    //   return AppRoutePath.roles();
    // }
    // if (name == createRoleRoute) {
    //   return AppRoutePath.createRoles();
    // }
    // if (name != null && name.startsWith(editRoleRoute)) {
    //   if (name.length > editRoleRoute.length) {
    //     final id = name.substring(editRoleRoute.length, name.length);
    //     if (id.isNotEmpty) return AppRoutePath.editRoles(id);
    //   }
    //   return AppRoutePath.roles();
    // }
    return AppRoutePath.unknown();
  }
}

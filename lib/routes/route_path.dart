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
      : name = posttaskRoute,
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

  AppRoutePath.confirmPage()
      : name = confirmPageRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.editProfile()
      : name = confirmPageRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.viewDetail()
      : name = viewDetailRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.postFast()
      : name = postFastRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.settingProfile()
      : name = settingProfileRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.setting()
      : name = settingRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.settingChangePassword()
      : name = settingChangePasswordRoute,
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
      : name = settingEditProfileRoute,
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

  AppRoutePath.register()
      : name = registerRoute,
        routeId = '',
        isUnknown = false;
  AppRoutePath.otp()
      : name = otpRoute,
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
    if (name == settingProfileRoute) {
      return AppRoutePath.settingProfile();
    }
    if (name == postFastRoute) {
      return AppRoutePath.postFast();
    }
    if (name == paymentRoute) {
      return AppRoutePath.payment();
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
    if (name == settingChangePasswordRoute) {
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
    if (name == posttaskRoute) {
      return AppRoutePath.posttask();
    }
    if (name == confirmPageRoute) {
      return AppRoutePath.confirmPage();
    }
    if (name == editProfileRoute) {
      return AppRoutePath.editProfile();
    }

    if (name == viewDetailRoute) {
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

import 'package:flutter/material.dart';
import 'package:hs_user_app/screens/home/booking_screen/booking_screen.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/choose_location/choose_location.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/confirm_page.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/edit_profile.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/edit_task_profile.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/post_fast.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/post_task.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/profile_tasker.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/promotion.dart';
import 'package:hs_user_app/screens/home/booking_screen/components/view_detail.dart';
import 'package:hs_user_app/screens/home/setting_screen/components/edit_profile.dart';
import 'package:hs_user_app/screens/home/setting_screen/components/payment.dart';
import 'package:hs_user_app/screens/home/setting_screen/components/profile_screen.dart';
import 'package:hs_user_app/screens/home/setting_screen/components/setting_change_password.dart';
import 'package:hs_user_app/screens/home/setting_screen/setting_screen.dart';
import 'package:hs_user_app/screens/home_screen/home_screen.dart';
import 'package:hs_user_app/screens/notification_screen/notification_screen.dart';
import 'package:hs_user_app/screens/otp_screen/otp_screen.dart';
import 'package:hs_user_app/screens/register_screen/register_screen.dart';
import '../screens/home/booking_screen/components/gps_page.dart';
import '/screens/forgot_password_screen/forgot_password_screen.dart';
import '/screens/onboarding/authentication_screen.dart';
import '../screens/not_found/page_not_found_screen.dart';
import 'no_animation_transition_delegate.dart';
import 'route_names.dart';
import 'route_path.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  String _routePath = '';

  @override
  AppRoutePath get currentConfiguration => AppRoutePath.routeFrom(_routePath);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      transitionDelegate: NoAnimationTransitionDelegate(),
      pages: [
        _pageFor(_routePath),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        notifyListeners();

        return true;
      },
    );
  }

  _pageFor(String route) {
    return MaterialPage(
      key: const ValueKey('HomeService'),
      child: _screenFor(route),
    );
  }

  _screenFor(String route) {
    if (route == initialRoute || route == authenticationRoute) {
      return const AuthenticationScreen();
    }
    //authentication
    if (route == homeRoute) {
      return const HomeScreen();
    }

    if (route == notificationRoute) {
      return const NotificationScreen();
    }

    if (route == bookingRoute) {
      return const Booking();
    }
    if (route == posttaskRoute) {
      return const PostTask();
    }
    if (route == promotionRoute) {
      return const Promotion();
    }
    if (route == editTaskProfileRoute) {
      return const EditTaskProfile();
    }
    if (route == postFastRoute) {
      return const PostFast();
    }
    if (route == paymentRoute) {
      return const Payment();
    }
    if (route == profileTaskersRoute) {
      return const ProfileTasker();
    }
    if (route == settingEditProfileRoute) {
      return const SettingEditProfile();
    }
    if (route == settingRoute) {
      return const SettingScreen();
    }
    if (route == settingChangePasswordRoute) {
      return const SettingChangePassword();
    }
    if (route == settingProfileRoute) {
      return const ProfileScreen();
    }

    if (route == gpsPageRoute) {
      return GoogleSearchPlacesApi();
    }

    if (route == chooseLocationRoute) {
      return const ChooseLocation();
    }
    if (route == confirmPageRoute) {
      return const Confirm();
    }
    if (route == editProfileRoute) {
      return const EditProfile();
    }
    if (route == viewDetailRoute) {
      return const ViewDetail();
    }

    if (route == forgotPasswordRoute) {
      return const ForgotPasswordScreen();
    }

    if (route == resetPasswordRoute) {
      return const ForgotPasswordScreen();
    }

    if (route == registerRoute) {
      return const RegisterScreen();
    }

    if (route == otpRoute) {
      return const OtpScreen();
    } // if (route == roleRoute) {
    //   return const UserManagementScreen(tab: 1);
    // }
    // if (route == createRoleRoute) {
    //   return const UserManagementScreen();
    // }
    // if (route.startsWith(editRoleRoute)) {
    //   if (route.length > editRoleRoute.length) {
    //     final id = route.substring(editRoleRoute.length + 1, route.length);
    //     if (id.isNotEmpty) return UserManagementScreen(id: id);
    //   }
    //   return const UserManagementScreen(tab: 1);
    // }

    return PageNotFoundScreen(route);
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _routePath = configuration.name!;
  }

  void navigateTo(String name) {
    _routePath = name;
    notifyListeners();
  }
}

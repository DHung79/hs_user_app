import 'package:flutter/material.dart';
import 'package:hs_user_app/screens/home/components/booking_content/rebook_task/rebook_task_screen.dart';
import '../screens/home/components/booking_content/components/choose_location/choose_location.dart';
import '../screens/home/components/booking_content/components/confirm_page.dart';
import '../screens/home/components/booking_content/components/edit_profile.dart';
import '../screens/home/components/booking_content/components/edit_task_profile.dart';
import '../screens/home/components/booking_content/components/gps_page.dart';
import '../screens/home/components/booking_content/components/pick_type_home.dart';

import '../screens/home/components/booking_content/components/post_task.dart';
import '../screens/home/components/booking_content/components/profile_tasker.dart';
import '../screens/home/components/booking_content/components/promotion.dart';
import '../screens/home/components/booking_content/components/view_detail.dart';
import '../screens/home/components/setting_content/components/edit_profile.dart';
import '../screens/home/components/setting_content/components/payment.dart';
import '../screens/home/components/setting_content/components/profile_screen.dart';
import '../screens/home/components/setting_content/components/setting_change_password.dart';
import '/screens/create_password_screen/create_password_screen.dart';
import '../screens/home/home_screen.dart';
import '/screens/notification_screen/notification_screen.dart';
import '/screens/otp_screen/otp_screen.dart';
import '/screens/register_screen/register_screen.dart';
import '/screens/reset_password_screen/reset_password_screen.dart';
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
      return const HomeScreen(homeTab: 1);
    }
    if (route == bookNewTaskRoute) {
      return PostTask(key: postTaskKey);
    }
    if (route == promotionRoute) {
      return const Promotion();
    }
    if (route == editTaskProfileRoute) {
      return const EditTaskProfile();
    }
    if (route.startsWith(rebookTaskRoute)) {
      if (route.length > rebookTaskRoute.length) {
        final id = route.substring(rebookTaskRoute.length + 1, route.length);
        if (id.isNotEmpty) return RebookTaskScreen(taskId: id);
      }
      return const HomeScreen(homeTab: 1);
    }

    if (route == paymentRoute) {
      return const Payment();
    }
    if (route == profileTaskersRoute) {
      return const ProfileTasker();
    }

    if (route == settingRoute) {
      return const HomeScreen(homeTab: 2);
    }
    if (route == userProfileRoute) {
      return const HomeScreen(
        homeTab: 2,
        settingTab: 1,
      );
    }
    if (route == editProfileRoute) {
      return const HomeScreen(
        homeTab: 2,
        settingTab: 2,
      );
    }
    if (route == userChangePasswordRoute) {
      return const HomeScreen(
        homeTab: 2,
        settingTab: 3,
      );
    }

    if (route == gpsPageRoute) {
      return GoogleSearchPlacesApi(
        key: googleSearchPlacesApiKey,
      );
    }

    if (route == profileUserRoute) {
      return const ProfileScreen();
    }

    if (route == chooseLocationRoute) {
      return ChooseLocation(
        key: chooseLocationKey,
      );
    }
    if (route == confirmRoute) {
      return const ConfirmPage();
    }
    if (route == editConfirmRoute) {
      return const EditProfile();
    }
    if (route == editPostFastRoute) {
      return const EditProfile();
    }
    if (route == taskDetailRoute) {
      return const ViewDetail();
    }

    if (route == forgotPasswordRoute) {
      return const ForgotPasswordScreen();
    }

    if (route == resetPasswordRoute) {
      return const ResetPasswordScreen();
    }

    if (route == createPasswordRoute) {
      return const CreatePasswordScreen();
    }

    if (route == registerRoute) {
      return const RegisterScreen();
    }

    if (route == otpForgotPassWordRoute) {
      return const OtpScreen();
    }
    if (route == otpRegisterRoute) {
      return const OtpScreen();
    }

    if (route == pickTypeHomeRoute) {
      return PickTypeHome(
        key: pickTypeHomeKey,
      );
    }

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

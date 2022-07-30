import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/home/components/booking_content/components/promotion.dart';
import '../screens/home/components/booking_content/contents/book_task/book_task_screen.dart';
import '../screens/home/components/booking_content/contents/task_booked/task_booked.dart';
import '../screens/home/components/booking_content/contents/task_history/components/task_history.dart';
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
      key: const ValueKey('Home Service User'),
      child: _screenFor(route),
    );
  }

  _screenFor(String route) {
    if (route == initialRoute || route == authenticationRoute) {
      return const AuthenticationScreen();
    }

    if (route == registerRoute) {
      return const RegisterScreen();
    }
    if (route == otpRegisterRoute) {
      return const OtpScreen(isRegister: true);
    }
    if (route == createPasswordRoute) {
      return const CreatePasswordScreen();
    }

    if (route == forgotPasswordRoute) {
      return const ForgotPasswordScreen();
    }
    if (route == otpForgotPassWordRoute) {
      return const OtpScreen();
    }
    if (route == resetPasswordRoute) {
      return const ResetPasswordScreen();
    }
    if (route == homeRoute) {
      return const HomeScreen();
    }

    if (route == bookTaskRoute) {
      return const HomeScreen(homeTab: 1);
    }
    if (route == bookNewTaskRoute) {
      return const BookTaskScreen();
    }
    if (route.startsWith(rebookTaskRoute)) {
      if (route.length > rebookTaskRoute.length) {
        final id = route.substring(rebookTaskRoute.length + 1, route.length);
        if (id.isNotEmpty) return BookTaskScreen(taskId: id);
      }
      return const HomeScreen(homeTab: 1);
    }
    if (route.startsWith(taskBookedRoute)) {
      if (route.length > taskBookedRoute.length) {
        final id = route.substring(taskBookedRoute.length + 1, route.length);
        if (id.isNotEmpty) return TaskBookedScreen(taskId: id);
      }
      return const HomeScreen(homeTab: 1, bookingTab: 1);
    }
    if (route.startsWith(taskHistoryRoute)) {
      if (route.length > taskHistoryRoute.length) {
        final id = route.substring(taskHistoryRoute.length + 1, route.length);
        if (id.isNotEmpty) return TaskHistoryScreen(taskId: id);
      }
      return const HomeScreen(homeTab: 1, bookingTab: 2);
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
    if (route == paymentRoute) {
      return const HomeScreen(
        homeTab: 2,
        settingTab: 4,
      );
    }

    if (route == notificationRoute) {
      return const NotificationScreen();
    }

    if (route == promotionRoute) {
      return const Promotion();
    }

    return PageNotFoundScreen(route);
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _routePath = configuration.name!;
  }

  void navigateTo(String name) {
    preRoute = _routePath;
    _routePath = name;
    notifyListeners();
  }
}

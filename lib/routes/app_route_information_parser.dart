import 'package:flutter/material.dart';
import 'route_names.dart';
import 'route_path.dart';

class AppRouteInforParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    final name = uri.path;

    if (name == initialRoute) {
      return AppRoutePath.initial();
    }
    if (name == homeRoute) {
      return AppRoutePath.home();
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

    if (name == bookTaskRoute) {
      return AppRoutePath.bookTask();
    }
    if (name == bookNewTaskRoute) {
      return AppRoutePath.bookNewTask();
    }
    if (name.startsWith(rebookTaskRoute)) {
      if (name.length > rebookTaskRoute.length) {
        final id = name.substring(rebookTaskRoute.length + 1, name.length);
        if (id.isNotEmpty) return AppRoutePath.rebookTask(id);
      }
      return AppRoutePath.bookTask();
    }
    if (name.startsWith(taskBookedRoute)) {
      if (name.length > taskBookedRoute.length) {
        final id = name.substring(taskBookedRoute.length + 1, name.length);
        if (id.isNotEmpty) return AppRoutePath.taskBooked(id);
      }
      return AppRoutePath.bookTask();
    }
    if (name.startsWith(taskHistoryRoute)) {
      if (name.length > taskHistoryRoute.length) {
        final id = name.substring(taskHistoryRoute.length + 1, name.length);
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
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: pageNotFoundRoute);
    }
    return RouteInformation(location: configuration.name);
  }
}

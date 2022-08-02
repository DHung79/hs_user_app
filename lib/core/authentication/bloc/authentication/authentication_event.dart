import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is loaded
class AppLoadedup extends AuthenticationEvent {}

class UserLogOut extends AuthenticationEvent {}

class GetUserData extends AuthenticationEvent {}

class UserSignUp extends AuthenticationEvent {
  final String password;

  const UserSignUp({required this.password});

  @override
  List<Object> get props => [password];
}

class UserLogin extends AuthenticationEvent {
  final String email;
  final String password;
  final bool keepSession;
  final bool isMobile;

  const UserLogin({
    required this.email,
    required this.password,
    required this.keepSession,
    required this.isMobile,
  });

  @override
  List<Object> get props => [email, password, keepSession];
}

class UserLoginGoogle extends AuthenticationEvent {
  final bool keepSession;
  final String accessToken;
  final bool isMobile;

  const UserLoginGoogle(
      {required this.keepSession,
      required this.accessToken,
      required this.isMobile});

  @override
  List<Object> get props => [accessToken, isMobile, keepSession];
}

class ForgotPassword extends AuthenticationEvent {
  final String email;

  const ForgotPassword({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPassword extends AuthenticationEvent {
  final String password;

  const ResetPassword({
    required this.password,
  });

  @override
  List<Object> get props => [password];
}

class CheckRegisterEmail extends AuthenticationEvent {
  final String email;

  const CheckRegisterEmail({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class UserLanguage extends AuthenticationEvent {
  final String lang;

  const UserLanguage({
    required this.lang,
  });

  @override
  List<Object> get props => [lang];
}

class TokenExpired extends AuthenticationEvent {}

class GetLastUser extends AuthenticationEvent {}

class CheckOTPForgot extends AuthenticationEvent {
  final String otp;

  const CheckOTPForgot({
    required this.otp,
  });

  @override
  List<Object> get props => [otp];
}

class CheckOTPRegister extends AuthenticationEvent {
  final String otp;

  const CheckOTPRegister({
    required this.otp,
  });

  @override
  List<Object> get props => [otp];
}

class SendOTP extends AuthenticationEvent {
  final String email;

  const SendOTP({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

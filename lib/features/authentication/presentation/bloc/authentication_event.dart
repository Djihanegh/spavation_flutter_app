part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class UserAddressChanged extends AuthenticationEvent {
  const UserAddressChanged({
    required this.address,
  });

  final DataMap address;

  @override
  List<Object?> get props => [address];
}

class GetUserEvent extends AuthenticationEvent {
  const GetUserEvent({
    required this.token,
  });

  final String token;

  @override
  List<Object?> get props => [token];
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({
    required this.user,
  });

  final UserModel user;

  @override
  List<Object?> get props => [user.toMap()];
}

class CheckOtpEvent extends AuthenticationEvent {
  const CheckOtpEvent({
    required this.otp,
  });

  final String otp;

  @override
  List<Object?> get props => [otp];
}

class ResendOtpEvent extends AuthenticationEvent {
  const ResendOtpEvent({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [email];
}

class LoginUserEvent extends AuthenticationEvent {
  const LoginUserEvent({
    required this.phone,
  });

  final String phone;

  @override
  List<Object?> get props => [phone];
}

class GenderChanged extends AuthenticationEvent {
  const GenderChanged({
    required this.gender,
  });

  final String gender;

  @override
  List<Object?> get props => [gender];
}

class NameChanged extends AuthenticationEvent {
  const NameChanged({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [name];
}

class PhoneChanged extends AuthenticationEvent {
  const PhoneChanged({
    required this.phone,
  });

  final String phone;

  @override
  List<Object?> get props => [phone];
}

class OtpChanged extends AuthenticationEvent {
  const OtpChanged({
    required this.otp,
  });

  final String otp;

  @override
  List<Object?> get props => [otp];
}

class EmailChanged extends AuthenticationEvent {
  const EmailChanged({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthenticationEvent {
  const PasswordChanged({
    required this.password,
  });

  final String password;

  @override
  List<Object?> get props => [password];
}

class ConfirmPasswordChanged extends AuthenticationEvent {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
  });

  final String confirmPassword;

  @override
  List<Object?> get props => [confirmPassword];
}

class SendForgetPasswordOtp extends AuthenticationEvent {
  const SendForgetPasswordOtp({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [email];
}

class CheckForgetPasswordOtp extends AuthenticationEvent {
  const CheckForgetPasswordOtp({
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}

class UpdatePassword extends AuthenticationEvent {
  const UpdatePassword({
    required this.password,
    required this.otp,
  });

  final String password;
  final String otp;

  @override
  List<Object?> get props => [password, otp];
}

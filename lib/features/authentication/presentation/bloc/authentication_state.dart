part of 'authentication_bloc.dart';

final class AuthenticationState extends Equatable {
  const AuthenticationState(
      {this.status = FormzSubmissionStatus.initial,
      this.name = '',
      this.phone = '',
      this.email = '',
      this.password = '',
      this.confirmPassword = '',
      this.gender = '',
      this.errorMessage = '',
      this.token = '',
      this.otp = ''});

  final FormzSubmissionStatus status;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final String gender;
  final String errorMessage;
  final String token;
  final String otp;

  AuthenticationState copyWith(
      {FormzSubmissionStatus? status,
      String? name,
      String? phone,
      String? email,
      String? password,
      String? confirmPassword,
      String? gender,
      String? errorMessage,
      String? token,
      String? otp}) {
    return AuthenticationState(
        status: status ?? this.status,
        name: name ?? this.name,
        password: password ?? this.password,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        gender: gender ?? this.gender,
        errorMessage: errorMessage ?? this.errorMessage,
        token: token ?? this.token,
        otp: otp ?? this.otp);
  }

  @override
  List<Object?> get props => [status, errorMessage];
}

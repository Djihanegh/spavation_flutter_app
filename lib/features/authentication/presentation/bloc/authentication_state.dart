part of 'authentication_bloc.dart';

enum AuthenticationStatus { initial, inProgress, failure, success }

final class AuthenticationState extends Equatable {
  const AuthenticationState(
      {this.action = RequestType.unknown,
      this.status = AuthenticationStatus.initial,
      this.name = '',
      this.phone = '',
      this.email = '',
      this.password = '',
      this.confirmPassword = '',
      this.gender = '',
      this.errorMessage = '',
      this.successMessage = '',
      this.token = '',
      this.otp = '',
      this.user,
      this.userAddress});

  final AuthenticationStatus status;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final String gender;
  final String errorMessage;
  final String successMessage;
  final String token;
  final String otp;
  final RequestType action;
  final Map<String, dynamic>? user;
  final Map<String, dynamic>? userAddress;

  AuthenticationState copyWith(
      {AuthenticationStatus? status,
      String? name,
      String? phone,
      String? email,
      String? password,
      String? confirmPassword,
      String? gender,
      String? errorMessage,
      String? token,
      String? otp,
      String? successMessage,
      RequestType? action,
      DataMap? user,
      DataMap? userAddress}) {
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
        otp: otp ?? this.otp,
        successMessage: successMessage ?? this.successMessage,
        action: action ?? this.action,
        user: user ?? this.user,
        userAddress: userAddress ?? this.userAddress);
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        email,
        gender,
        token,
        action,
        successMessage,
        phone,
        password,
        confirmPassword,
        name,
        user,
        userAddress
      ];
}

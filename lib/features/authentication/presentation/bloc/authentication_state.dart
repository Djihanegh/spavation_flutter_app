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
      this.token = ''});

  final FormzSubmissionStatus status;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;
  final String gender;
  final String errorMessage;
  final String token;

  AuthenticationState copyWith(
      {FormzSubmissionStatus? status,
      String? name,
      String? phone,
      String? email,
      String? password,
      String? confirmPassword,
      String? gender,
      String? errorMessage,
      String? token}) {
    return AuthenticationState(
        status: status ?? this.status,
        name: name ?? this.name,
        password: password ?? this.password,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        gender: gender ?? this.gender,
        errorMessage: errorMessage ?? this.errorMessage,
        token: token ?? this.token);
  }

  @override
  List<Object?> get props => [status, errorMessage];
}

/*class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();

  @override
  List<Object?> get props => [];
}

class UserCreated extends AuthenticationState {
  const UserCreated(this.createdUserResponse);

  final CreateUserResponse createdUserResponse;

  @override
  List<Object?> get props =>
      [createdUserResponse.message, createdUserResponse.status];
}

class LoginUserState extends AuthenticationState {
  const LoginUserState();

  @override
  List<Object?> get props => [];
}

class UserLoggedIn extends AuthenticationState {
  const UserLoggedIn(this.userResponse);

  final LoginUserResponse userResponse;

  @override
  List<Object?> get props => [
        userResponse.name,
        userResponse.email,
        userResponse.message,
        userResponse.status
      ];
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}*/

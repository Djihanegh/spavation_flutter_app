part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
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
}

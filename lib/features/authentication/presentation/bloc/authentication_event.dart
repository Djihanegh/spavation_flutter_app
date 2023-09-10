part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({
    required this.user,
  });

  final UserModel user;

  @override
  List<Object?> get props => [user.toMap()];
}

class LoginUserEvent extends AuthenticationEvent {
  const LoginUserEvent({
    required this.phone,
    required this.password,
  });

  final String phone;
  final String password;

  @override
  List<Object?> get props => [phone, password];
}

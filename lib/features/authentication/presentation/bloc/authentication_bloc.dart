import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/features/authentication/data/models/user_model.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:spavation/features/authentication/domain/usecases/register_user_usecase.dart';

import '../../domain/entities/create_user_response.dart';
import '../../domain/usecases/login_user_usecase.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required RegisterUser registerUser, required LoginUser loginUser})
      : _registerUser = registerUser,
        _loginUser = loginUser,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<LoginUserEvent>(_loginUserHandler);
  }

  final RegisterUser _registerUser;
  final LoginUser _loginUser;

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUser());

    final result = await _registerUser(event.user);

    result.fold((l) => emit(AuthenticationError(l.message)),
        (r) => emit(UserCreated(r)));
  }

  Future<void> _loginUserHandler(
      LoginUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const LoginUserState());

    final result = await _loginUser(UserModel.loginUserModel(
        UserModel(password: event.password, phone: event.phone)));

    result.fold((l) => emit(AuthenticationError(l.message)),
        (r) => emit(UserLoggedIn(r)));
  }
}

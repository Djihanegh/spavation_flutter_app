import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/features/authentication/data/models/user_model.dart';
import 'package:spavation/features/authentication/domain/usecases/check_otp.dart';
import 'package:spavation/features/authentication/domain/usecases/register_user_usecase.dart';

import '../../domain/usecases/login_user_usecase.dart';
import '../../domain/usecases/resend_otp.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required RegisterUser registerUser,
    required LoginUser loginUser,
    required CheckOtpUseCase checkOtpUseCase,
    required ResendOtpUseCase resendOtpUseCase,
  })  : _registerUser = registerUser,
        _loginUser = loginUser,
        _checkOtp = checkOtpUseCase,
        _resendOtp = resendOtpUseCase,
        super(const AuthenticationState()) {
    on<CreateUserEvent>(_createUserHandler);
    on<LoginUserEvent>(_loginUserHandler);
    on<CheckOtpEvent>(_checkOtpHandler);
    on<ResendOtpEvent>(_resendOtpHandler);

    on<EmailChanged>(_emailChanged);
    on<NameChanged>(_nameChanged);
    on<PhoneChanged>(_phoneChanged);
    on<PasswordChanged>(_passwordChanged);
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<GenderChanged>(_genderChanged);
  }

  final RegisterUser _registerUser;
  final LoginUser _loginUser;
  final CheckOtpUseCase _checkOtp;
  final ResendOtpUseCase _resendOtp;

  Future<void> _resendOtpHandler(
      ResendOtpEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _resendOtp(event.email);

    result.fold(
        (l) => emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(
            state.copyWith(status: FormzSubmissionStatus.success, otp: r.otp)));
  }

  Future<void> _checkOtpHandler(
      CheckOtpEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _checkOtp(event.otp);

    result.fold(
        (l) => emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
              status: FormzSubmissionStatus.success,
            )));
  }

  Future<void> _emailChanged(
      EmailChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(email: event.email, gender: state.gender));
  }

  Future<void> _nameChanged(
      NameChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(name: event.name, gender: state.gender));
  }

  Future<void> _phoneChanged(
      PhoneChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(phone: event.phone, gender: state.gender));
  }

  Future<void> _passwordChanged(
      PasswordChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(password: event.password, gender: state.gender));
  }

  Future<void> _confirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        confirmPassword: event.confirmPassword, gender: state.gender));
  }

  Future<void> _genderChanged(
      GenderChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(gender: event.gender));
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, gender: state.gender));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _registerUser(event.user);

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            gender: state.gender)),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            token: r.token,
            gender: state.gender)));
  }

  Future<void> _loginUserHandler(
      LoginUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, gender: state.gender));

    await Future.delayed(const Duration(seconds: 3));

    final result = await _loginUser(UserModel.loginUserModel(
        UserModel(password: event.password, email: event.email)));

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            gender: state.gender)),
        (r) => emit(state.copyWith(
            gender: state.gender,
            status: FormzSubmissionStatus.success,
            token: r.token,
            email: r.email,
            name: r.name)));
  }
}

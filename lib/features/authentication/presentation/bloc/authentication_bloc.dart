import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/data/models/user_model.dart';
import 'package:spavation/features/authentication/domain/usecases/check_otp.dart';
import 'package:spavation/features/authentication/domain/usecases/get_user.dart';
import 'package:spavation/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/send_otp_forget_password_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/update_password_usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/login_user_response.dart';
import '../../domain/usecases/check_otp_forget_password.dart';
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
    required GetUserUseCase getUserUseCase,
    required UpdatePasswordUseCase updatePasswordUseCase,
    required SendOtpForgetPasswordUseCase sendOtpForgetPasswordUseCase,
    required CheckOtpForgetPasswordUseCase checkOtpForgetPasswordUseCase,
  })  : _registerUser = registerUser,
        _loginUser = loginUser,
        _checkOtp = checkOtpUseCase,
        _resendOtp = resendOtpUseCase,
        _getUserUseCase = getUserUseCase,
        _updatePasswordUseCase = updatePasswordUseCase,
        _sendOtpForgetPasswordUseCase = sendOtpForgetPasswordUseCase,
        _checkOtpForgetPasswordUseCase = checkOtpForgetPasswordUseCase,
        super(const AuthenticationState()) {
    on<CreateUserEvent>(_createUserHandler);
    on<LoginUserEvent>(_loginUserHandler);
    on<CheckOtpEvent>(_checkOtpHandler);
    on<ResendOtpEvent>(_resendOtpHandler);
    on<GetUserEvent>(_getUserHandler);

    on<EmailChanged>(_emailChanged);
    on<NameChanged>(_nameChanged);
    on<PhoneChanged>(_phoneChanged);
    on<PasswordChanged>(_passwordChanged);
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<GenderChanged>(_genderChanged);
    on<UserAddressChanged>(_userAddressChanged);
    on<SendForgetPasswordOtp>(_onSendOtpForgetPassword);
    on<CheckForgetPasswordOtp>(_onCheckOtpForgetPassword);
    on<UpdatePassword>(_onUpdatePassword);
    on<OtpChanged>(_onOtpChanged);
  }

  final RegisterUser _registerUser;
  final LoginUser _loginUser;
  final CheckOtpUseCase _checkOtp;
  final ResendOtpUseCase _resendOtp;
  final GetUserUseCase _getUserUseCase;
  final UpdatePasswordUseCase _updatePasswordUseCase;
  final SendOtpForgetPasswordUseCase _sendOtpForgetPasswordUseCase;
  final CheckOtpForgetPasswordUseCase _checkOtpForgetPasswordUseCase;

  Future<void> _onOtpChanged(
      OtpChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(otp: event.otp, email: state.email));
  }

  Future<void> _onUpdatePassword(
      UpdatePassword event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        action: RequestType.unknown, status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 2));

    final result = await _updatePasswordUseCase(
        {'password': event.password, 'otp': event.otp});

    result.fold(
        (l) => emit(state.copyWith(
            action: RequestType.updatePass,
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            user: {})),
        (r) => emit(state.copyWith(
              action: RequestType.updatePass,
              status: FormzSubmissionStatus.success,
            )));
  }

  Future<void> _onCheckOtpForgetPassword(
      CheckForgetPasswordOtp event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        action: RequestType.unknown, status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _checkOtpForgetPasswordUseCase(
        {'email': event.email, 'otp': event.otp});

    result.fold(
        (l) => emit(state.copyWith(
              action: RequestType.checkOtpForgetPass,
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            action: RequestType.checkOtpForgetPass,
            status: FormzSubmissionStatus.success,
            successMessage: r['message'])));
  }

  Future<void> _onSendOtpForgetPassword(
      SendForgetPasswordOtp event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        action: RequestType.unknown, status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 20));

    final result = await _sendOtpForgetPasswordUseCase(event.email);

    result.fold(
        (l) => emit(state.copyWith(
              action: RequestType.sendOtpForgetPass,
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            action: RequestType.sendOtpForgetPass,
            status: FormzSubmissionStatus.success,
            successMessage: r['message'])));
  }

  Future<void> _userAddressChanged(
      UserAddressChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(userAddress: event.address, email: state.email));
  }

  Future<void> _getUserHandler(
      GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        action: RequestType.unknown, status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 2));

    final result = await _getUserUseCase(event.token);

    result.fold(
        (l) => emit(state.copyWith(
            action: RequestType.getUser,
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            user: {})),
        (r) => emit(state.copyWith(
            action: RequestType.getUser,
            status: FormzSubmissionStatus.success,
            successMessage: r.message,
            user: r.user)));
  }

  Future<void> _resendOtpHandler(
      ResendOtpEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        action: RequestType.unknown, status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 30));

    final result = await _resendOtp(event.email);

    result.fold(
        (l) => emit(state.copyWith(
              action: RequestType.resendOtp,
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            action: RequestType.resendOtp,
            status: FormzSubmissionStatus.success,
            successMessage: r.message)));
  }

  Future<void> _checkOtpHandler(
      CheckOtpEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        action: RequestType.unknown, status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 30));

    final result = await _checkOtp(event.otp);

    result.fold(
        (l) => emit(state.copyWith(
              action: RequestType.checkOtp,
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            action: RequestType.checkOtp,
            status: FormzSubmissionStatus.success,
            successMessage: r.message)));
  }

  Future<void> _emailChanged(
      EmailChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      email: event.email,
      gender: state.gender,
    ));
  }

  Future<void> _nameChanged(
      NameChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        name: event.name, gender: state.gender, email: state.email));
  }

  Future<void> _phoneChanged(
      PhoneChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        phone: event.phone, gender: state.gender, email: state.email));
  }

  Future<void> _passwordChanged(
      PasswordChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        password: event.password, gender: state.gender, email: state.email));
  }

  Future<void> _confirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        confirmPassword: event.confirmPassword,
        gender: state.gender,
        email: state.email));
  }

  Future<void> _genderChanged(
      GenderChanged event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(gender: event.gender, email: state.email));
    await Future.delayed(const Duration(milliseconds: 30));
  }

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        action: RequestType.unknown,
        status: FormzSubmissionStatus.inProgress,
        gender: state.gender));
    await Future.delayed(const Duration(milliseconds: 30));

    final result = await _registerUser(event.user);

    result.fold(
        (l) => emit(state.copyWith(
            action: RequestType.createUser,
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            gender: state.gender,
            email: state.email)),
        (r) => emit(state.copyWith(
            action: RequestType.createUser,
            status: FormzSubmissionStatus.success,
            token: r.token,
            gender: state.gender,
            successMessage: r.message,
            email: state.email)));
  }

  Future<void> _loginUserHandler(
      LoginUserEvent event, Emitter<AuthenticationState> emit) async {
    Either<Failure, LoginUserResponse> failureOrSuccess;

    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
      gender: state.gender,
      action: RequestType.unknown,
    ));

    await Future.delayed(const Duration(seconds: 2));

    failureOrSuccess = await _loginUser(UserModel.loginUserModel(UserModel(
      phone: event.phone,
    )));

    failureOrSuccess.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            gender: state.gender,
            action: RequestType.loginUser,
            email: state.email)),
        (r) => emit(state.copyWith(
              action: RequestType.loginUser,
              gender: state.gender,
              status: FormzSubmissionStatus.success,
              //  token: r.token,
              email: r.email,
              name: r.name,
              successMessage: r.message,
            )));
  }
}

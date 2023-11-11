import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/settings/domain/usecases/delete_user.dart';
import 'package:spavation/features/settings/domain/usecases/get_user_details.dart';
import 'package:spavation/features/settings/domain/usecases/update_user.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
      {required GetUserDetailsUseCase getUserDetailsUseCase,
      required DeleteUserUseCase deleteUserUseCase,
      required UpdateUserUseCase updateUserUseCasez})
      : _deleteUserUseCase = deleteUserUseCase,
        _getUserDetailsUseCase = getUserDetailsUseCase,
        _updateUserUseCase = updateUserUseCasez,
        super(const SettingsState()) {
    on<GetUserDetailsEvent>(_getUserHandler);
    on<DeleteUserEvent>(_deleteUserHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  final DeleteUserUseCase _deleteUserUseCase;
  final GetUserDetailsUseCase _getUserDetailsUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  Future<void> _updateUserHandler(
      UpdateUserEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(
        status: SettingsStatus.inProgress,
        customers: {},
        action: RequestType.updateUser));
    await Future.delayed(const Duration(seconds: 2));

    final result = await _updateUserUseCase(event.body);

    result.fold(
        (l) => emit(state.copyWith(
            customers: {},
            status: SettingsStatus.failure,
            errorMessage: l.message,
            action: RequestType.updateUser)),
        (r) => emit(state.copyWith(
            customers: {},
            action: RequestType.updateUser,
            status: SettingsStatus.success,
            successMessage: r.message)));
  }

  Future<void> _deleteUserHandler(
      DeleteUserEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.inProgress));
    await Future.delayed(const Duration(seconds: 2));

    final result = await _deleteUserUseCase(event.token);

    result.fold(
        (l) => emit(state.copyWith(
            status: SettingsStatus.failure,
            errorMessage: l.message,
            action: RequestType.deleteUser)),
        (r) => emit(state.copyWith(
            action: RequestType.deleteUser,
            status: SettingsStatus.success,
            successMessage: r.message)));
  }

  Future<void> _getUserHandler(
      GetUserDetailsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.inProgress));
    await Future.delayed(const Duration(seconds: 1));

    final result = await _getUserDetailsUseCase(event.token);

    result.fold(
        (l) => emit(state.copyWith(
              status: SettingsStatus.failure,
              errorMessage: l.message,
              action: RequestType.getUserDetails,
            )),
        (r) => emit(state.copyWith(
            status: SettingsStatus.success,
            action: RequestType.getUserDetails,
            customers: r.Customers,
            successMessage: r.message)));
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../data/models/reservation_model.dart';
import '../../domain/usecases/get_reservations.dart';

part 'reservation_event.dart';

part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc({required GetReservationsUseCase getReservationsUseCase})
      : _getReservationsUseCase = getReservationsUseCase,
        super(const ReservationState()) {
    on<GetReservationsEvent>(_getReservationsHandler);
  }

  final GetReservationsUseCase _getReservationsUseCase;

  Future<void> _getReservationsHandler(
      GetReservationsEvent event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _getReservationsUseCase(event.id);

    result.fold(
        (l) => emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            reservations: r.data,
            successMessage: r.message)));
  }
}

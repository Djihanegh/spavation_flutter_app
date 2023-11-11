import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/usecases/add_reservation.dart';
import 'package:spavation/features/reservation/domain/usecases/check_coupon.dart';
import '../../data/models/reservation_model.dart';
import '../../domain/usecases/get_reservations.dart';

part 'reservation_event.dart';

part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc(
      {required GetReservationsUseCase getReservationsUseCase,
      required CheckCouponUseCase checkCouponUseCase,
      required AddReservationUseCase addReservationUseCase})
      : _getReservationsUseCase = getReservationsUseCase,
        _checkCouponUseCase = checkCouponUseCase,
        _addReservationUseCase = addReservationUseCase,
        super(const ReservationState()) {
    on<GetReservationsEvent>(_getReservationsHandler);
    on<CheckCouponEvent>(_onCheckCoupon);
    on<AddReservationEvent>(_addReservation);
    on<InitializeDiscount>(_onInitializeDiscount);
  }

  final GetReservationsUseCase _getReservationsUseCase;
  final CheckCouponUseCase _checkCouponUseCase;
  final AddReservationUseCase _addReservationUseCase;

  Future<void> _onInitializeDiscount(
      InitializeDiscount event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(discount: "0.0", status: ReservationStatus.canceled));
    emit(state.copyWith(discount: "0.0", status: ReservationStatus.initial));
  }

  Future<void> _addReservation(
      AddReservationEvent event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(
        status: ReservationStatus.inProgress,
        action: RequestType.addReservation));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _addReservationUseCase(event.data);

    result.fold(
        (l) => emit(state.copyWith(
            status: ReservationStatus.failure,
            errorMessage: l.message,
            action: RequestType.addReservation)),
        (r) => emit(state.copyWith(
            status: ReservationStatus.success,
            successMessage: r.message,
            action: RequestType.addReservation)));
  }

  Future<void> _onCheckCoupon(
      CheckCouponEvent event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(status: ReservationStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _checkCouponUseCase(
        {'salon_id': event.salonId, 'code': event.code});

    result.fold(
        (l) => emit(state.copyWith(
            status: ReservationStatus.failure,
            errorMessage: l.message,
            action: RequestType.checkCoupon)),
        (r) => emit(state.copyWith(
            discount: r.copoun.discount,
            status: ReservationStatus.success,
            successMessage: r.message,
            action: RequestType.checkCoupon)));
  }

  Future<void> _getReservationsHandler(
      GetReservationsEvent event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(status: ReservationStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _getReservationsUseCase(event.id);

    result.fold(
        (l) => emit(state.copyWith(
              status: ReservationStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            status: ReservationStatus.success,
            reservations: r.data,
            successMessage: r.message)));
  }
}

part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
}

class GetReservationsEvent extends ReservationEvent {
  const GetReservationsEvent(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class CheckCouponEvent extends ReservationEvent {
  const CheckCouponEvent(this.salonId, this.code);

  final String salonId;
  final String code;

  @override
  List<Object?> get props => [salonId, code];
}

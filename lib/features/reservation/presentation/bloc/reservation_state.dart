part of 'reservation_bloc.dart';

final class ReservationState extends Equatable {
  const ReservationState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.reservations,
      this.discount = '',
      this.action = RequestType.unknown});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<ReservationModel>? reservations;
  final RequestType action;
  final String discount;

  ReservationState copyWith(
      {FormzSubmissionStatus? status,
      String? errorMessage,
      String? successMessage,
      List<ReservationModel>? reservations,
      RequestType? action,
      String? discount}) {
    return ReservationState(
        discount: discount ?? this.discount,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        reservations: reservations ?? this.reservations,
        action: action ?? this.action);
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, successMessage, reservations, action, discount];
}

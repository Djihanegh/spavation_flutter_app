part of 'reservation_bloc.dart';

final class ReservationState extends Equatable {
  const ReservationState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.reservations});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<ReservationModel>? reservations;

  ReservationState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    List<ReservationModel>? reservations,
  }) {
    return ReservationState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        reservations: reservations ?? this.reservations);
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, successMessage, reservations];
}

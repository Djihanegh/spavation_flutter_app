part of 'salon_bloc.dart';

final class SalonState extends Equatable {
  const SalonState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.salons});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<SalonModel>? salons;

  SalonState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    List<SalonModel>? salons,
  }) {
    return SalonState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        salons: salons ?? this.salons);
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage, salons];
}

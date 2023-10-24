part of 'salon_bloc.dart';

final class SalonState extends Equatable {
  const SalonState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.salons,
      this.filteredSalons,
      this.filterOptions,
      this.action = RequestType.unknown});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<SalonModel>? salons;
  final List<SalonModel>? filteredSalons;
  final DataMap? filterOptions;
  final RequestType action;

  SalonState copyWith(
      {FormzSubmissionStatus? status,
      String? errorMessage,
      String? successMessage,
      List<SalonModel>? salons,
      final RequestType? action,
      final List<SalonModel>? filteredSalons,
      DataMap? filterOptions}) {
    return SalonState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        salons: salons ?? this.salons,
        action: action ?? this.action,
        filteredSalons: filteredSalons ?? this.filteredSalons,
        filterOptions: filterOptions ?? this.filterOptions);
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        successMessage,
        salons,
        action,
        filteredSalons,
        filterOptions
      ];
}

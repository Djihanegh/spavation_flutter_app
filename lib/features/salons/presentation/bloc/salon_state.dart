part of 'salon_bloc.dart';

final class SalonState extends Equatable {
  const SalonState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.salons,
      this.filteredSalons,
      this.filterOptions,
      this.categoryId = -1,
      this.cityId = 1,
      this.action = RequestType.unknown,
      this.applyFilter = false});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<SalonModel>? salons;
  final List<SalonModel>? filteredSalons;
  final DataMap? filterOptions;
  final RequestType action;
  final bool applyFilter;
  final int categoryId;
  final int cityId;

  SalonState copyWith(
      {FormzSubmissionStatus? status,
      String? errorMessage,
      String? successMessage,
      List<SalonModel>? salons,
      final RequestType? action,
      final List<SalonModel>? filteredSalons,
      DataMap? filterOptions,
      int? categoryId,
      int? cityId,
      bool? applyFilter}) {
    return SalonState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        salons: salons ?? this.salons,
        action: action ?? this.action,
        cityId: cityId ?? this.cityId,
        filteredSalons: filteredSalons ?? this.filteredSalons,
        filterOptions: filterOptions ?? this.filterOptions,
        applyFilter: applyFilter ?? this.applyFilter,
        categoryId: categoryId ?? this.categoryId);
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        successMessage,
        salons,
        action,
        filteredSalons,
        filterOptions,
        applyFilter,
        categoryId,
        cityId
      ];
}

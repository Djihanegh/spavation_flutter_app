part of 'cities_bloc.dart';

final class CityState extends Equatable {
  const CityState({
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.cities,
    this.action = RequestType.unknown,
  });

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<CitiesModel>? cities;

  final RequestType action;

  CityState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    List<CitiesModel>? cities,
    final RequestType? action,
  }) {
    return CityState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      cities: cities ?? this.cities,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        successMessage,
        action,
        cities,
      ];
}

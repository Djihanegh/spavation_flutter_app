part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.customers,
      this.action = RequestType.unknown});

  final FormzSubmissionStatus status;
  final String errorMessage;
  final String successMessage;
  final DataMap? customers;
  final RequestType action;

  SettingsState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    DataMap? customers,
    RequestType? action,
  }) {
    return SettingsState(
        customers: customers ?? this.customers,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        action: action ?? this.action);
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, successMessage, customers, action];
}



/*abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitialState extends CityState {}

class CityInProgressState extends CityState {}

class CityLoadDataSuccessState extends CityState {
  final List<CitiesModel> cities;

  @override
  List<Object> get props => [cities];

  const CityLoadDataSuccessState({
    required this.cities,
  });
}

class CityLoadDataFailureState extends CityState {
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  const CityLoadDataFailureState({
    required this.errorMessage,
  });
}
*/
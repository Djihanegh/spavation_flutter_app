part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState( {
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.customers ,
  });

  final FormzSubmissionStatus status;
  final String errorMessage;
  final String successMessage;
  final DataMap? customers;

  SettingsState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    DataMap? customers
  }) {
    return SettingsState(
      customers: customers ?? this.customers,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage, customers];
}

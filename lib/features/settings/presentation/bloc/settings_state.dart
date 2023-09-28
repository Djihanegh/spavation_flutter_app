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

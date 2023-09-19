part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class GetUserDetailsEvent extends SettingsEvent {
  const GetUserDetailsEvent(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

class DeleteUserEvent extends SettingsEvent {
  const DeleteUserEvent(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

class UpdateUserEvent extends SettingsEvent {
  const UpdateUserEvent(this.body);

  final DataMap body;

  @override
  List<Object?> get props => [body];
}

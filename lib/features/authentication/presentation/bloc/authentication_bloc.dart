import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';

import '../../domain/entities/create_user_response.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

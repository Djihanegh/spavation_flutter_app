import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons.dart';

part 'salon_event.dart';

part 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  SalonBloc({required GetSalonsUseCase getSalonsUseCase})
      : _getSalonsUseCase = getSalonsUseCase,
        super(const SalonState()) {
    on<GetSalonsEvent>(_getSalonsHandler);
  }

  final GetSalonsUseCase _getSalonsUseCase;

  Future<void> _getSalonsHandler(
      GetSalonsEvent event, Emitter<SalonState> emit) async {
    log('LOADING');
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _getSalonsUseCase();

    log('BLOC SALON');

    result.fold(
        (l) => emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            salons: r.salons,
            successMessage: '')));
  }
}

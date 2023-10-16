import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons_by_category.dart';

part 'salon_event.dart';

part 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  SalonBloc(
      {required GetSalonsUseCase getSalonsUseCase,
      required GetSalonsByCategoryUseCase getSalonsByCategoryUseCase})
      : _getSalonsUseCase = getSalonsUseCase,
        _getSalonsByCategoryUseCase = getSalonsByCategoryUseCase,
        super(const SalonState()) {
    on<GetSalonsEvent>(_getSalonsHandler);

    on<GetSalonsByCategoryEvent>(_getSalonsByCategoryHandler);
  }

  final GetSalonsUseCase _getSalonsUseCase;
  final GetSalonsByCategoryUseCase _getSalonsByCategoryUseCase;

  Future<void> _getSalonsByCategoryHandler(
      GetSalonsByCategoryEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _getSalonsByCategoryUseCase(event.id);

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            action: RequestType.getSalonsByCategory)),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            salons: r.salons,
            action: RequestType.getSalonsByCategory,
            successMessage: '')));
  }

  Future<void> _getSalonsHandler(
      GetSalonsEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _getSalonsUseCase();

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            action: RequestType.getSalons)),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            salons: r.salons,
            action: RequestType.getSalons,
            successMessage: '')));
  }
}

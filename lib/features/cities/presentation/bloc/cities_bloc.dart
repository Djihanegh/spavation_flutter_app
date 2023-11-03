import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/cities/data/models/cities_model.dart';
import '../../domain/usecases/get_cities.dart';

part 'city_event.dart';

part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc({
    required GetCitiesUseCase getCitiesUseCase,
  })  : _getCitiesUseCase = getCitiesUseCase,
        super(const CityState()) {
    on<GetCitiesEvent>(_getCitiesHandler);
  }

  final GetCitiesUseCase _getCitiesUseCase;

  Future<void> _getCitiesHandler(
      GetCitiesEvent event, Emitter<CityState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _getCitiesUseCase();

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            action: RequestType.getCities)),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            cities: r.cities,
            action: RequestType.getCities,
            successMessage: '')));
  }
}

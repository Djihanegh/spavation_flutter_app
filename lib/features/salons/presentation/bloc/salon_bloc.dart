import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons.dart';
import 'package:spavation/features/salons/domain/usecases/search_salons_by_category.dart';
import '../../../../core/utils/typedef.dart';

part 'salon_event.dart';

part 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  SalonBloc(
      {required GetSalonsUseCase getSalonsUseCase,
      required SearchSalonsUseCase searchSalonsUseCase})
      : _getSalonsUseCase = getSalonsUseCase,
        _searchSalonsUseCase = searchSalonsUseCase,
        super(const SalonState()) {
    on<GetSalonsEvent>(_getSalonsHandler);
    on<SearchSalonsEvent>(_onSearchSalons);
    on<SelectFilterOptions>(_onSelectFilterOptions);
  }

  final GetSalonsUseCase _getSalonsUseCase;
  final SearchSalonsUseCase _searchSalonsUseCase;

  Future<void> _onSelectFilterOptions(
      SelectFilterOptions event, Emitter<SalonState> emit) async {
    int categoryId = state.categoryId;
    emit(state.copyWith(
        status: SalonsStatus.inProgress, filteredSalons: null));

    DataMap options = state.filterOptions ?? {};

    if (event.options['gender'] != null) {
      options['gender'] = event.options['gender'];
    }
    if (event.options['open_now'] != null) {
      options['open_now'] = event.options['open_now'];
    }
    if (event.options['near_by'] != null) {
      options['near_by'] = event.options['near_by'];
    }
    if (event.options['city'] != null) {
      options['city'] = event.options['city'];
    }
    if (event.options['categoryId'] != null) {
      options['categoryId'] = event.options['categoryId'];
      categoryId = int.parse(options['categoryId']);
    }

    emit(state.copyWith(
      categoryId: categoryId,
      status: SalonsStatus.success,
      filterOptions: options,
    ));
  }

  Future<void> _onSearchSalons(
      SearchSalonsEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: SalonsStatus.inProgress, filteredSalons: null));
    await Future.delayed(const Duration(milliseconds: 20));

    final result = await _searchSalonsUseCase(event.text);

    result.fold(
        (l) => emit(state.copyWith(
            status: SalonsStatus.failure,
            errorMessage: l.message,
            action: RequestType.searchSalons)),
        (r) => emit(state.copyWith(
            filterOptions: state.filterOptions,
            categoryId: state.categoryId,
            applyFilter: state.applyFilter,
            status: SalonsStatus.success,
            filteredSalons: r.salons,
            action: RequestType.searchSalons,
            successMessage: '')));
  }

  Future<void> _getSalonsHandler(
      GetSalonsEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(status: SalonsStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    int categoryId = state.categoryId;
    bool applyFilter = state.applyFilter;
    DataMap queryParams = event.queryParameters;

    if (queryParams['category_id'] != null) {
      if (categoryId == int.parse(queryParams['category_id'])) {
        applyFilter = false;
        categoryId = int.parse(queryParams['category_id']);
        queryParams.remove('category_id');
      } else {
        applyFilter = true;
        categoryId = int.parse(queryParams['category_id']);
      }
    }

    final result = await _getSalonsUseCase(queryParams);

    result.fold(
        (l) => emit(state.copyWith(
            status: SalonsStatus.failure,
            errorMessage: l.message,
            action: RequestType.getSalons)),
        (r) => emit(state.copyWith(
            filterOptions: queryParams,
            categoryId: categoryId,
            applyFilter: applyFilter,
            status: SalonsStatus.success,
            salons: r.salons,
            action: RequestType.getSalons,
            successMessage: '')));
  }
}

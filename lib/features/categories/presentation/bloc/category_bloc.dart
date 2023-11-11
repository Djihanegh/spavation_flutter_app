import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/features/categories/data/models/category_model.dart';
import 'package:spavation/features/categories/domain/usecases/get_categories.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required GetCategoriesUseCase getCategoriesUseCase})
      : _getCategoriesUseCase = getCategoriesUseCase,
        super(CategoryInitialState()) {
    on<GetCategoriesEvent>(_getCategoriesHandler);
  }

  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> _getCategoriesHandler(
      GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit.call(CategoryInProgressState());
    await Future.delayed(const Duration(milliseconds: 20));

    final result = await _getCategoriesUseCase();

    result.fold(
        (l) => emit.call(CategoryLoadDataFailureState(errorMessage: l.message)),
        (r) => emit.call(
            CategoryLoadDataSuccessState(categories: r.categories ?? [])));
  }
}

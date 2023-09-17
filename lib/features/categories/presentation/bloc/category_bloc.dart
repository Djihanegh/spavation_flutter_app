import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/features/categories/data/models/category_model.dart';
import 'package:spavation/features/categories/domain/usecases/get_categories.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required GetCategoriesUseCase getCategoriesUseCase})
      : _getCategoriesUseCase = getCategoriesUseCase,
        super(const CategoryState()) {
    on<GetCategoriesEvent>(_getCategoriesHandler);
  }

  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> _getCategoriesHandler(
      GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 2));

    final result = await _getCategoriesUseCase();



    result.fold(
        (l) => emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            data: r.categories,
            successMessage: '')));
  }
}

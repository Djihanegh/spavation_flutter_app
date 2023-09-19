import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/features/products/data/models/product_model.dart';
import 'package:spavation/features/products/domain/usecases/get_products.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(const ProductState()) {
    on<GetProductsEvent>(_getProductsHandler);
  }

  final GetProductsUseCase _getProductsUseCase;

  Future<void> _getProductsHandler(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 2));

    final result = await _getProductsUseCase(event.salonId);

    result.fold(
        (l) => emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: l.message,
            )),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            data: r.products,
            successMessage: '')));
  }
}

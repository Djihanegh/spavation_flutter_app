import 'dart:async';
import 'dart:developer';

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
    on<SelectProduct>(_onSelectProduct);
    on<RemoveProduct>(_onRemoveProduct);

  }

  final GetProductsUseCase _getProductsUseCase;

  void _onRemoveProduct(RemoveProduct event, Emitter<ProductState> emit) {
    List<ProductModel> products = state.selectedProducts ?? [];

    if (products.contains(event.product)) {
      products.remove(event.product);
    }
    emit(state.copyWith(selectedProducts: products));


    log(state.selectedProducts.toString());
  }

  void _onSelectProduct(SelectProduct event, Emitter<ProductState> emit) {
    List<ProductModel> products = state.selectedProducts ?? [];

    if (!products.contains(event.product)) {
      products.add(event.product);
    }
    emit(state.copyWith(selectedProducts: products));
  }

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

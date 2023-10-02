import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/features/products/data/models/product_model.dart';
import 'package:spavation/features/products/domain/usecases/get_products.dart';

import '../../../../core/utils/typedef.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(const ProductState()) {
    on<GetProductsEvent>(_getProductsHandler);
    on<SelectProduct>(_onSelectProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<SelectDate>(_onSelectDate);
    on<SelectTime>(_onSelectTime);
  }

  final GetProductsUseCase _getProductsUseCase;

  void _onSelectDate(SelectDate event, Emitter<ProductState> emit) {
    Map<String, List<DataMap>> dates = state.reservations ?? {};

    List<DataMap> list = dates[event.salonId] ?? [];

    emit(state.copyWith(
        selectedDate: event.date, status: FormzSubmissionStatus.initial));

    if (list.isNotEmpty) {
      int index =
          list.indexWhere((element) => element['id'] == event.productId);
      if (index == -1) {
        list.add({'id': event.productId, 'date': event.date});
      } else {
        DataMap data = list[index];
        if (event.date != data['date']) {
          data['date'] = event.date;

          //  list.removeAt(index);
          // list.insert(index, {'id': event.productId, 'date': event.date});
        } else {
          data['date'] = null;
        }
      }
    } else {
      list.add({'id': event.productId, 'date': event.date});
    }

    dates[event.salonId] = list;
    emit(state.copyWith(
        reservations: dates, status: FormzSubmissionStatus.success));
  }

  void _onSelectTime(SelectTime event, Emitter<ProductState> emit) {
    emit(state.copyWith(selectedTime: event.time));

    Map<String, List<DataMap>> dates = state.reservations ?? {};

    List<DataMap> list = dates[event.salonId] ?? [];

    emit(state.copyWith(
        selectedTime: event.time, status: FormzSubmissionStatus.initial));

    if (list.isNotEmpty) {
      int index =
          list.indexWhere((element) => element['id'] == event.productId);
      if (index == -1) {
        list.add({'id': event.productId, 'time': event.time});
      } else {
        DataMap data = list[index];

        if (event.time != data['time']) {
          data['time'] = event.time;
        } else {
          data['time'] = null;
        }

        list[index] = data;
      }
    } else {
      list.add({'id': event.productId, 'time': event.time});
    }

    dates[event.salonId] = list;
    emit(state.copyWith(
        reservations: dates, status: FormzSubmissionStatus.success));
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<ProductState> emit) {
    List<ProductModel> products = state.selectedProducts ?? [];

    Map<String, List<DataMap>>? reservations = state.reservations;

    emit(state.copyWith(status: FormzSubmissionStatus.initial));

    if (products.contains(event.product)) {
      products.remove(event.product);
    }

    if (reservations != null) {
      if (reservations.containsKey(event.product.salonId)) {
        List<DataMap>? data = reservations[event.product.salonId];
        if (data != null) {
          int index = data
              .indexWhere((element) => element['id'] == event.product.id);

          if (index != -1) {
            data.removeAt(index);
          }

          reservations[event.product.salonId] = data;
        }
      }
    }

    emit(state.copyWith(
        selectedDate: null,
        selectedTime: '',
        selectedProducts: products,
        reservations: reservations,
        status: FormzSubmissionStatus.success));
  }

  void _onSelectProduct(SelectProduct event, Emitter<ProductState> emit) {
    List<ProductModel> products = state.selectedProducts ?? [];

    emit(state.copyWith(status: FormzSubmissionStatus.initial));

    if (!products.contains(event.product)) {
      products.add(event.product);
    }
    emit(state.copyWith(
        selectedProducts: products, status: FormzSubmissionStatus.success));
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

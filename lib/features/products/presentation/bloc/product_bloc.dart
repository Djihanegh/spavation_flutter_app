import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/features/products/data/models/product_model.dart';
import 'package:spavation/features/products/domain/usecases/get_product_times_usecase.dart';
import 'package:spavation/features/products/domain/usecases/get_products.dart';

import '../../../../core/enum/enum.dart';
import '../../../../core/utils/typedef.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(
      {required GetProductsUseCase getProductsUseCase,
      required GetProductTimesUseCase getProductTimesUseCase})
      : _getProductsUseCase = getProductsUseCase,
        _getProductTimesUseCase = getProductTimesUseCase,
        super(const ProductState()) {
    on<GetProductsEvent>(_getProductsHandler);
    on<GetProductTimesEvent>(_getProductTimesHandler);
    on<SelectProduct>(_onSelectProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<SelectDate>(_onSelectDate);
    on<SelectTime>(_onSelectTime);
    on<RemoveReservation>(_onRemoveReservation);
  }

  final GetProductsUseCase _getProductsUseCase;
  final GetProductTimesUseCase _getProductTimesUseCase;

  Future<void> _getProductTimesHandler(
      GetProductTimesEvent event, Emitter<ProductState> emit) async {
    //  emit(state.copyWith(timeIntervals: []));

    final result =
        await _getProductTimesUseCase({"id": event.id, "date": event.date});

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            status: ProductStatus.failure,
            timeIntervals: [])), (r) {
      if (r.timeIntervals != null) {
        if (r.timeIntervals != []) {
          emit(state.copyWith(
              successMessage: '',
              timeIntervals: r.timeIntervals ?? [],
              status: ProductStatus.success));
        } else {
          emit(state.copyWith(
              successMessage: r.message,
              timeIntervals: r.timeIntervals ?? [],
              status: ProductStatus.success));
        }
      } else {
        emit(state.copyWith(
            successMessage: r.message,
            timeIntervals: r.timeIntervals ?? [],
            status: ProductStatus.success));
      }
    });
  }

  void _onRemoveReservation(
      RemoveReservation event, Emitter<ProductState> emit) {
    emit(state.copyWith(
        selectedDate: null,
        selectedProducts: [],
        reservations: {},
        selectedTime: null));
  }

  void _onSelectDate(SelectDate event, Emitter<ProductState> emit) {
    Map<String, List<DataMap>> dates = state.reservations ?? {};

    List<DataMap> list = dates[event.salonId] ?? [];

    emit(state.copyWith(
        selectedDate: event.date, status: ProductStatus.initial));

    if (list.isNotEmpty) {
      int index =
          list.indexWhere((element) => element['id'] == event.productId);
      if (index == -1) {
        list.add({'id': event.productId, 'date': event.date});
      } else {
        DataMap data = list[index];
        if (event.date != data['date']) {
          data['date'] = event.date;
        } else {
          data['date'] = null;
        }
      }
    } else {
      list.add({'id': event.productId, 'date': event.date});
    }

    dates[event.salonId] = list;
    emit(state.copyWith(reservations: dates, status: ProductStatus.success));
  }

  void _onSelectTime(SelectTime event, Emitter<ProductState> emit) {
    emit(state.copyWith(selectedTime: event.time));

    Map<String, List<DataMap>> dates = state.reservations ?? {};

    List<DataMap> list = dates[event.salonId] ?? [];

    emit(state.copyWith(
        selectedTime: event.time, status: ProductStatus.initial));

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
    emit(state.copyWith(reservations: dates, status: ProductStatus.success));
  }

  void _onRemoveProduct(RemoveProduct event, Emitter<ProductState> emit) {
    List<ProductModel> products = state.selectedProducts ?? [];

    Map<String, List<DataMap>>? reservations = state.reservations;

    int productIndex = 0;

    for (ProductModel product in products) {
      if (product.id == event.product.id) {
        productIndex = products.indexOf(product);
      }
    }

    products.removeAt(productIndex);

    if (reservations != null) {
      if (reservations.containsKey(event.product.salonId)) {
        List<DataMap>? data = reservations[event.product.salonId];
        if (data != null) {
          int index =
              data.indexWhere((element) => element['id'] == event.product.id);

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
        status: ProductStatus.initial));

    emit(state.copyWith(
        selectedDate: null,
        selectedTime: '',
        selectedProducts: products,
        reservations: reservations,
        status: ProductStatus.success));
  }

  void _onSelectProduct(SelectProduct event, Emitter<ProductState> emit) {
    List<ProductModel> products = state.selectedProducts ?? [];

    emit(state.copyWith(status: ProductStatus.initial));

    if (!products.contains(event.product)) {
      products.add(event.product);
    }
    emit(state.copyWith(
      selectedProducts: products,
      status: ProductStatus.success,
    ));
  }

  Future<void> _getProductsHandler(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _getProductsUseCase(event.salonId);

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, status: ProductStatus.failure)),
        (r) => emit(state.copyWith(
            data: r.products ?? [], status: ProductStatus.success)));
  }
}

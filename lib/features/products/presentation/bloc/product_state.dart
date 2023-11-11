part of 'product_bloc.dart';

enum ProductStatus { initial, inProgress, failure, success, unknown }
final class ProductState extends Equatable {
  const ProductState(
      {this.status = ProductStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.data,
      this.selectedProducts,
      this.selectedDate,
      this.selectedTime,
      this.reservations,
      this.timeIntervals,
      this.action = RequestType.unknown});

  final ProductStatus status;
  final String errorMessage;
  final String successMessage;
  final List<ProductModel>? data;
  final List<ProductModel>? selectedProducts;
  final DateTime? selectedDate;
  final String? selectedTime;
  final List<String>? timeIntervals;
  final Map<String, List<DataMap>>? reservations;
  final RequestType action;

  ProductState copyWith(
      {ProductStatus? status,
      String? errorMessage,
      String? successMessage,
      List<ProductModel>? data,
      List<ProductModel>? selectedProducts,
      DateTime? selectedDate,
      String? selectedTime,
      List<String>? timeIntervals,
      Map<String, List<DataMap>>? reservations,
      RequestType? action}) {
    return ProductState(
        status: status ?? this.status,
        timeIntervals: timeIntervals ?? this.timeIntervals,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        data: data ?? this.data,
        selectedProducts: selectedProducts ?? this.selectedProducts,
        selectedDate: selectedDate ?? this.selectedDate,
        selectedTime: selectedTime ?? this.selectedTime,
        reservations: reservations ?? this.reservations,
        action: action ?? this.action);
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        successMessage,
        data,
        selectedProducts,
        timeIntervals,
        selectedDate,
        selectedTime,
        reservations,
        action
      ];
}


/*class ProductState extends Equatable {
  const ProductState(
      {this.selectedProducts,
      this.selectedDate,
      this.selectedTime,
      this.reservations,
      this.data,
      this.status = ProductStatus.initial});

  final List<ProductModel>? selectedProducts;
  final DateTime? selectedDate;
  final String? selectedTime;
  final Map<String, List<DataMap>>? reservations;
  final ProductStatus status;
  final List<ProductModel>? data;

  ProductState copyWith({
    List<ProductModel>? selectedProducts,
    DateTime? selectedDate,
    String? selectedTime,
    Map<String, List<DataMap>>? reservations,
    ProductStatus? status,
    List<ProductModel>? data,
  }) {
    return ProductState(
        selectedProducts: selectedProducts ?? this.selectedProducts,
        selectedDate: selectedDate ?? this.selectedDate,
        selectedTime: selectedTime ?? this.selectedTime,
        reservations: reservations ?? this.reservations,
        data: data ?? this.data,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        selectedProducts,
        status,
        selectedDate,
        selectedTime,
        reservations,
        data
      ];
}

// GET PRODUCTS STATE
class GetProductsInitialState extends ProductState {}

class GetProductsInProgressState extends ProductState {}

class GetProductsLoadDataSuccessState extends ProductState {
  final List<ProductModel> products;

  @override
  List<Object> get props => [products];

  const GetProductsLoadDataSuccessState({
    required this.products,
  });
}

class GetProductsLoadDataFailureState extends ProductState {
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  const GetProductsLoadDataFailureState({
    required this.errorMessage,
  });
}
// GET PRODUCT TIMES STATE

class GetProductTimesInitialState extends ProductState {}

class GetProductTimesInProgressState extends ProductState {}

class GetProductTimesLoadDataSuccessState extends ProductState {
  final List<String> timeIntervals;

  @override
  List<Object> get props => [timeIntervals];

  const GetProductTimesLoadDataSuccessState({
    required this.timeIntervals,
  });
}

class GetProductTimesLoadDataFailureState extends ProductState {
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  const GetProductTimesLoadDataFailureState({
    required this.errorMessage,
  });
} */

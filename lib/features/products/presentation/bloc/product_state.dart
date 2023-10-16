part of 'product_bloc.dart';

final class ProductState extends Equatable {
  const ProductState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.data,
      this.selectedProducts,
      this.selectedDate,
      this.selectedTime,
      this.reservations,
      this.action = RequestType.unknown});

  final FormzSubmissionStatus status;
  final String errorMessage;
  final String successMessage;
  final List<ProductModel>? data;
  final List<ProductModel>? selectedProducts;
  final DateTime? selectedDate;
  final String? selectedTime;
  final Map<String, List<DataMap>>? reservations;
  final RequestType action;

  ProductState copyWith(
      {FormzSubmissionStatus? status,
      String? errorMessage,
      String? successMessage,
      List<ProductModel>? data,
      List<ProductModel>? selectedProducts,
      DateTime? selectedDate,
      String? selectedTime,
      Map<String, List<DataMap>>? reservations,
      RequestType? action}) {
    return ProductState(
        status: status ?? this.status,
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
        selectedDate,
        selectedTime,
        reservations,
        action
      ];
}

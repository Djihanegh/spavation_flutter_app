part of 'product_bloc.dart';

final class ProductState extends Equatable {
  const ProductState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.data,
      this.selectedProducts});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<ProductModel>? data;
  final List<ProductModel>? selectedProducts;

  ProductState copyWith(
      {FormzSubmissionStatus? status,
      String? errorMessage,
      String? successMessage,
      List<ProductModel>? data,
      List<ProductModel>? selectedProducts}) {
    return ProductState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        data: data ?? this.data,
        selectedProducts: selectedProducts ?? this.selectedProducts);
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, successMessage, data, selectedProducts];
}

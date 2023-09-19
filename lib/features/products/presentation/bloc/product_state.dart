part of 'product_bloc.dart';

final class ProductState extends Equatable {
  const ProductState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.data});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<ProductModel>? data;

  ProductState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    List<ProductModel>? data,
  }) {
    return ProductState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        data: data ?? this.data);
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage, data];
}

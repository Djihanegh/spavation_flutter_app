part of 'category_bloc.dart';

final class CategoryState extends Equatable {
  const CategoryState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.data});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<CategoryModel>? data;

  CategoryState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    List<CategoryModel>? data,
  }) {
    return CategoryState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        data: data ?? this.data);
  }

  @override
  List<Object?> get props => [status, errorMessage, successMessage, data];
}

part of 'category_bloc.dart';


abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState {}

class CategoryInProgressState extends CategoryState {}

class CategoryLoadDataSuccessState extends CategoryState {
  final List<CategoryModel> categories;

  @override
  List<Object> get props => [categories];

  const CategoryLoadDataSuccessState({
    required this.categories,
  });
}

class CategoryLoadDataFailureState extends CategoryState {
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  const CategoryLoadDataFailureState({
    required this.errorMessage,
  });
}


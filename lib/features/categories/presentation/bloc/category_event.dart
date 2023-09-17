part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategoriesEvent extends CategoryEvent {
  const GetCategoriesEvent();

  @override
  List<Object?> get props => [];
}

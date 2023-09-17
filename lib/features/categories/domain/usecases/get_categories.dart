import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/categories/domain/repositories/category_repository.dart';
import '../entities/get_category_response.dart';

class GetCategoriesUseCase extends UseCaseWithoutParams<GetCategoryResponse> {
  const GetCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  @override
  ResultFuture<GetCategoryResponse> call() async => _repository.getCategory();
}

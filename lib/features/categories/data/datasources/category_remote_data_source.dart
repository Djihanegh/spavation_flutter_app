import '../../domain/entities/get_category_response.dart';

abstract class CategoryRemoteDataSource {
  Future<GetCategoryResponse> getCategory();
}

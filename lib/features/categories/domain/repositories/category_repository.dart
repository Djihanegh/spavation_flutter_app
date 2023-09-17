import 'package:spavation/core/utils/typedef.dart';

import '../entities/get_category_response.dart';

abstract class CategoryRepository {
  const CategoryRepository();

  ResultFuture<GetCategoryResponse> getCategory();
}

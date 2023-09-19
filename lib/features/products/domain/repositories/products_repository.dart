import 'package:spavation/core/utils/typedef.dart';

import '../entities/get_products_response.dart';

abstract class ProductsRepository {
  const ProductsRepository();

  ResultFuture<GetProductsResponse> getProducts({required String id});
}

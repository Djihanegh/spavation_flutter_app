import 'package:spavation/features/products/domain/entities/entities.dart';

import '../../domain/entities/get_products_response.dart';

abstract class ProductsRemoteDataSource {
  Future<GetProductsResponse> getProducts({required String id, required String type});

  Future<GetProductTimesResponse> getProductTimes({required String date, required int id});
}

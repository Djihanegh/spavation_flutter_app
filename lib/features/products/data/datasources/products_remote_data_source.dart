import '../../domain/entities/get_products_response.dart';

abstract class ProductsRemoteDataSource {
  Future<GetProductsResponse> getProducts({required String id});
}

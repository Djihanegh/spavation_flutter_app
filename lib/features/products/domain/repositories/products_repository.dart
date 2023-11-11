import 'package:spavation/core/utils/typedef.dart';
import '../entities/entities.dart';

abstract class ProductsRepository {
  const ProductsRepository();

  ResultFuture<GetProductsResponse> getProducts({required String id});

  ResultFuture<GetProductTimesResponse> getProductTimes({required String date, required int id });
}

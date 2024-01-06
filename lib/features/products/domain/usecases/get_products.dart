import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/products/domain/repositories/products_repository.dart';
import '../entities/get_products_response.dart';

class GetProductsUseCase extends UseCaseWithParams<GetProductsResponse,DataMap> {
  const GetProductsUseCase(this._repository);

  final ProductsRepository _repository;

  @override
  ResultFuture<GetProductsResponse> call(DataMap params) async => _repository.getProducts(id: params['id'], type: params['type']);
}

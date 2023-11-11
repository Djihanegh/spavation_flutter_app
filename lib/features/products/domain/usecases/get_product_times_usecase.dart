import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/products/domain/entities/entities.dart';
import 'package:spavation/features/products/domain/repositories/products_repository.dart';

class GetProductTimesUseCase extends UseCaseWithParams<GetProductTimesResponse,DataMap> {
  const GetProductTimesUseCase(this._repository);

  final ProductsRepository _repository;

  @override
  ResultFuture<GetProductTimesResponse> call(DataMap params) async => _repository.getProductTimes(id: params['id'], date: params['date']);
}
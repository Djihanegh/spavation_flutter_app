import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/products/data/datasources/products_remote_data_source.dart';
import 'package:spavation/features/products/domain/entities/get_product_times_response.dart';
import 'package:spavation/features/products/domain/entities/get_products_response.dart';
import 'package:spavation/features/products/domain/repositories/products_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';

class ProductsRepositoryImplementation implements ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;

  ProductsRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<GetProductsResponse> getProducts({required String id}) async {
    try {
      final result = await _remoteDataSource.getProducts(id: id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<GetProductTimesResponse> getProductTimes({required String date, required int id}) async {
    try {
      final result = await _remoteDataSource.getProductTimes(id: id, date: date);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }


}

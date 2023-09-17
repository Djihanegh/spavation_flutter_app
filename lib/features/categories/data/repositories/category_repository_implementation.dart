import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:spavation/features/categories/domain/entities/get_category_response.dart';
import 'package:spavation/features/categories/domain/repositories/category_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';

class CategoryRepositoryImplementation implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<GetCategoryResponse> getCategory() async {
    try {
      final result = await _remoteDataSource.getCategory();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}

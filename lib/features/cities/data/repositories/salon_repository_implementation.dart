import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/cities/data/datasources/cities_remote_data_source.dart';
import 'package:spavation/features/cities/domain/entities/get_cities_response.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/cities_repository.dart';

class CitiesRepositoryImplementation implements CitiesRepository {
  final CitiesRemoteDataSource _remoteDataSource;

  CitiesRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<GetCitiesResponse> getCities() async {
    try {
      final result = await _remoteDataSource.getCities();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}

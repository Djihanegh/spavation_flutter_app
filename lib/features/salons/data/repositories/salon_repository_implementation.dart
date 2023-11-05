import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source.dart';
import 'package:spavation/features/salons/domain/entities/get_salons_response.dart';
import 'package:spavation/features/salons/domain/repositories/salon_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/get_salons_by_category_response.dart';
import '../models/salon_model.dart';

class SalonRepositoryImplementation implements SalonRepository {
  final SalonRemoteDataSource _remoteDataSource;

  SalonRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<GetSalonsResponse> getSalons(DataMap data) async {
    try {
      final result = await _remoteDataSource.getSalons(data);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<GetSalonsByCategoryResponse> getSalonsByCategory(String id) async {
    try {
      final result = await _remoteDataSource.getSalonsByCategory(id);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}

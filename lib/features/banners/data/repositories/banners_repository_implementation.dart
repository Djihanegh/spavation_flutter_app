import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/banners/data/datasources/banners_remote_data_source.dart';
import 'package:spavation/features/banners/domain/entities/get_banners_response.dart';
import 'package:spavation/features/banners/domain/repositories/banners_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';

class BannersRepositoryImplementation implements BannersRepository {
  final BannersRemoteDataSource _remoteDataSource;

  BannersRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<GetBannersResponse> getBanners() async {
    try {
      final result = await _remoteDataSource.getBanners();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}

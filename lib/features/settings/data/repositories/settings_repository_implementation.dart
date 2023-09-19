import 'package:dartz/dartz.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/settings/domain/repositories/settings_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/base_response.dart';
import '../../domain/entities/get_user_details_response.dart';
import '../datasources/settings_remote_data_source.dart';

class SettingsRepositoryImplementation implements SettingsRepository {
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<BaseResponse> deleteUser({required String token}) async {
    try {
      final result = await _remoteDataSource.deleteUser(token: token);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<GetUserDetailsResponse> getUserDetails({required String token}) async {
    try {
      final result = await _remoteDataSource.getUserDetails(token: token);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<BaseResponse> updateUser({required DataMap body}) async {
    try {
      final result = await _remoteDataSource.updateUser(body: body);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }


}

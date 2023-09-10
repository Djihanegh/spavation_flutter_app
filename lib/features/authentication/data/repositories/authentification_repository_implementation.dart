import 'package:dartz/dartz.dart';
import 'package:spavation/core/errors/failure.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/user.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImplementation(this._remoteDataSource);

  @override
  ResultFuture<CreateUserResponse> createUser({required UserModel user}) async {
    try {
      final result = await _remoteDataSource.createUser(user: user);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<LoginUserResponse> loginUser({required UserModel user}) async {
    try {
      final result = await _remoteDataSource.loginUser(user: user);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}

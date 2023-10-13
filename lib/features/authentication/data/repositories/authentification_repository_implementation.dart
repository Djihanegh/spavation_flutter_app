import 'package:dartz/dartz.dart';
import 'package:spavation/core/errors/failure.dart';
import 'package:spavation/core/utils/base_response.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/get_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/resend_otp_response.dart';
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

  @override
  ResultFuture<BaseResponse> checkOtp({required String otp}) async {
    try {
      final result = await _remoteDataSource.checkOtp(otp: otp);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<ResendOtpResponse> resendOtp({required String email}) async {
    try {
      final result = await _remoteDataSource.resendOtp(email: email);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<GetUserResponse> getUser({required String token}) async {
    try {
      final result = await _remoteDataSource.getUser(token: token);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<DataMap> checkOtpForgotPassword(
      {required String otp, required String email}) async {
    try {
      final result = await _remoteDataSource.checkOtpForgotPassword(
          email: email, otp: otp);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<DataMap> sendOtpForgotPassword({required String email}) async {
    try {
      final result =
          await _remoteDataSource.sendOtpForgotPassword(email: email);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }

  @override
  ResultFuture<BaseResponse> updatePassword(
      {required String otp, required String email}) async {
    try {
      final result =
          await _remoteDataSource.updatePassword(email: email, otp: otp);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fomException(e));
    }
  }
}

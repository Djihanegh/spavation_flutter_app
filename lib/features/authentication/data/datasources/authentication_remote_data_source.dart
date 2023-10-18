import 'package:spavation/features/authentication/domain/entities/get_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import '../../../../core/utils/base_response.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/create_user_response.dart';

import '../../domain/entities/resend_otp_response.dart';
import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  @override
  Future<CreateUserResponse> createUser({required UserModel user});

  Future<LoginUserResponse> loginUser({required UserModel user});

  Future<BaseResponse> checkOtp({required String otp});

  Future<BaseResponse> resendOtp({required String email});

  Future<GetUserResponse> getUser({required String token});

  Future<DataMap> checkOtpForgotPassword(
      {required String otp, required String email});

  Future<DataMap> sendOtpForgotPassword({required String email});

  Future<DataMap> updatePassword(
      {required String otp, required String email});
}

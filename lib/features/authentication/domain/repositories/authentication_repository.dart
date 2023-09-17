import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';

import '../../../../core/utils/base_response.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/models/user_model.dart';
import '../entities/resend_otp_response.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<CreateUserResponse> createUser({required UserModel user});

  ResultFuture<LoginUserResponse> loginUser({required UserModel user});

  ResultFuture<BaseResponse> checkOtp({required String otp});

  ResultFuture<ResendOtpResponse> resendOtp({required String email});
}

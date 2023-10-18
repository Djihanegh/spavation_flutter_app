
import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/domain/entities/resend_otp_response.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/utils/base_response.dart';

class ResendOtpUseCase extends UseCaseWithParams<BaseResponse, String> {
  const ResendOtpUseCase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<BaseResponse> call(String params) async =>
      _repository.resendOtp(email: params);
}

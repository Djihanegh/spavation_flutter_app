import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';


class CheckOtpForgetPasswordUseCase
    extends UseCaseWithParams<DataMap, DataMap> {
  const CheckOtpForgetPasswordUseCase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<DataMap> call(DataMap params) async => _repository
      .checkOtpForgotPassword(email: params['email'], otp: params['otp']);
}

import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';

class SendOtpForgetPasswordUseCase extends UseCaseWithParams<DataMap, String> {
  const SendOtpForgetPasswordUseCase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<DataMap> call(String params) async =>
      _repository.sendOtpForgotPassword(email: params);
}

import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/utils/base_response.dart';

class UpdatePasswordUseCase extends UseCaseWithParams<DataMap, DataMap> {
  const UpdatePasswordUseCase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<DataMap> call(DataMap params) async =>
      _repository.updatePassword(email: params['password'], otp: params['otp']);
}

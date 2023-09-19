import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/domain/entities/get_user_response.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/utils/base_response.dart';

class GetUserUseCase extends UseCaseWithParams<GetUserResponse, String> {
  const GetUserUseCase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<GetUserResponse> call(String params) async =>
      _repository.getUser(token: params);
}

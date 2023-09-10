import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';

import '../../data/models/user_model.dart';

class RegisterUser extends UseCaseWithParams<CreateUserResponse, UserModel> {
  const RegisterUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<CreateUserResponse> call(UserModel params) async =>
      _repository.createUser(user: params);
}

import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';

import '../../data/models/user_model.dart';

class LoginUser extends UseCaseWithParams<LoginUserResponse, UserModel> {
  const LoginUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<LoginUserResponse> call(UserModel params) async =>
      _repository.loginUser(user: params);
}

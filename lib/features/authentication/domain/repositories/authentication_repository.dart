import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';
import '../../data/models/user_model.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<CreateUserResponse> createUser({required UserModel user});

  ResultFuture<LoginUserResponse> loginUser({required UserModel user});
}

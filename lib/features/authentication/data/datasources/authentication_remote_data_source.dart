import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';

import '../../domain/entities/create_user_response.dart';
import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  @override
  Future<CreateUserResponse> createUser({required UserModel user});

  Future<LoginUserResponse> loginUser({required UserModel user});
}

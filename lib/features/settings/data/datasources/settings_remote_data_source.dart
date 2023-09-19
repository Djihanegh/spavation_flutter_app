import 'package:spavation/core/utils/typedef.dart';
import '../../../../core/utils/base_response.dart';
import '../../domain/entities/get_user_details_response.dart';


abstract class SettingsRemoteDataSource {
  Future<BaseResponse> deleteUser({required String token});

  Future<GetUserDetailsResponse> getUserDetails({required String token});

  Future<BaseResponse> updateUser({required DataMap body});

}

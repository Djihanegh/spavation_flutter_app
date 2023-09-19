import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/settings/domain/entities/get_user_details_response.dart';

import '../../../../core/utils/base_response.dart';

abstract class SettingsRepository {
  const SettingsRepository();

  ResultFuture<BaseResponse> deleteUser({required String token});

  ResultFuture<GetUserDetailsResponse> getUserDetails({required String token});

  ResultFuture<BaseResponse> updateUser({required DataMap body});
}

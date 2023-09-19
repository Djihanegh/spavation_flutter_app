import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/settings/domain/entities/get_user_details_response.dart';
import '../repositories/settings_repository.dart';
import 'package:spavation/core/usecase/usecase.dart';

class GetUserDetailsUseCase extends UseCaseWithParams<GetUserDetailsResponse, String> {
  const GetUserDetailsUseCase(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<GetUserDetailsResponse> call(params) async =>
      _repository.getUserDetails(token: params);
}

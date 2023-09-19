import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import '../../../../core/utils/base_response.dart';
import '../repositories/settings_repository.dart';

class UpdateUserUseCase extends UseCaseWithParams<BaseResponse, DataMap> {
  const UpdateUserUseCase(this._repository);

  final SettingsRepository _repository;

  @override
  ResultFuture<BaseResponse> call(params) async =>
      _repository.updateUser(body: params);
}

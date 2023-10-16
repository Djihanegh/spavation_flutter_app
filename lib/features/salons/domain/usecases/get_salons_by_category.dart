import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/salons/domain/repositories/salon_repository.dart';
import '../entities/get_salons_response.dart';

class GetSalonsByCategoryUseCase
    extends UseCaseWithParams<GetSalonsResponse, String> {
  const GetSalonsByCategoryUseCase(this._repository);

  final SalonRepository _repository;

  @override
  ResultFuture<GetSalonsResponse> call(String params) async =>
      _repository.getSalonsByCategory(params);
}

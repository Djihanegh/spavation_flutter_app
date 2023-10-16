import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/salons/domain/entities/get_salons_response.dart';
import 'package:spavation/features/salons/domain/repositories/salon_repository.dart';
import '../../data/models/salon_model.dart';

class GetSalonsByCategoryUseCase
    extends UseCaseWithParams<GetSalonsResponse, String> {
  const GetSalonsByCategoryUseCase(this._repository);

  final SalonRepository _repository;

  @override
  ResultFuture<GetSalonsResponse> call(String params) async =>
      _repository.getSalonsByCategory(params);
}

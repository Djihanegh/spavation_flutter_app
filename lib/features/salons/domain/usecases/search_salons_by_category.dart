import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/salons/domain/entities/get_salons_response.dart';
import 'package:spavation/features/salons/domain/repositories/salon_repository.dart';

class SearchSalonsUseCase
    extends UseCaseWithParams<GetSalonsResponse, String> {
  const SearchSalonsUseCase(this._repository);

  final SalonRepository _repository;

  @override
  ResultFuture<GetSalonsResponse> call(String params) async =>
      _repository.searchSalons(params);
}

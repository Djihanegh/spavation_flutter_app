import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/cities/domain/repositories/cities_repository.dart';
import '../entities/get_cities_response.dart';

class GetCitiesUseCase extends UseCaseWithoutParams<GetCitiesResponse> {
  const GetCitiesUseCase(this._repository);

  final CitiesRepository _repository;

  @override
  ResultFuture<GetCitiesResponse> call() async => _repository.getCities();
}

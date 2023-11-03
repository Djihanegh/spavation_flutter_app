
import '../../domain/entities/get_cities_response.dart';

abstract class CitiesRemoteDataSource {
  Future<GetCitiesResponse> getCities();
}

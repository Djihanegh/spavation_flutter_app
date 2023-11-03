import 'package:spavation/core/utils/typedef.dart';

import '../entities/get_cities_response.dart';

abstract class CitiesRepository {
  const CitiesRepository();

  ResultFuture<GetCitiesResponse> getCities();
}

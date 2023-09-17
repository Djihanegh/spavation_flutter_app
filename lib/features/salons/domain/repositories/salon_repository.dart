import 'package:spavation/core/utils/typedef.dart';

import '../entities/get_salons_response.dart';

abstract class SalonRepository {
  const SalonRepository();

  ResultFuture<GetSalonsResponse> getSalons();
}

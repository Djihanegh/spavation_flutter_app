import 'package:spavation/core/utils/typedef.dart';

import '../entities/get_salons_by_category_response.dart';
import '../entities/get_salons_response.dart';

abstract class SalonRepository {
  const SalonRepository();

  ResultFuture<GetSalonsResponse> getSalons(DataMap data);

  ResultFuture<GetSalonsByCategoryResponse> getSalonsByCategory(String id);
}

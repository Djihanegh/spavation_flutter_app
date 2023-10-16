import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/salon_model.dart';
import '../entities/get_salons_response.dart';

abstract class SalonRepository {
  const SalonRepository();

  ResultFuture<GetSalonsResponse> getSalons();

  ResultFuture<GetSalonsResponse> getSalonsByCategory(String id);
}

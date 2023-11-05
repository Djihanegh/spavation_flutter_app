import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/salons/domain/entities/get_salons_by_category_response.dart';

import '../../domain/entities/get_salons_response.dart';

abstract class SalonRemoteDataSource {
  Future<GetSalonsResponse> getSalons(DataMap data);

  Future<GetSalonsByCategoryResponse> getSalonsByCategory(String id);
}

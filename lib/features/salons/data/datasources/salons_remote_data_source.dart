import 'package:spavation/core/utils/typedef.dart';
import '../../domain/entities/get_salons_response.dart';

abstract class SalonRemoteDataSource {
  Future<GetSalonsResponse> getSalons(DataMap data);

  Future<GetSalonsResponse> searchSalons(String name);
}

import '../../domain/entities/get_salons_response.dart';

abstract class SalonRemoteDataSource {
  Future<GetSalonsResponse> getSalons();

  Future<GetSalonsResponse> getSalonsByCategory(String id);
}

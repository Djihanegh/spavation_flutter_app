import '../../domain/entities/get_salons_response.dart';
import '../models/salon_model.dart';

abstract class SalonRemoteDataSource {
  Future<GetSalonsResponse> getSalons();

  Future<GetSalonsResponse> getSalonsByCategory(String id);
}

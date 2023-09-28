import '../../domain/entities/get_reservations_response.dart';

abstract class ReservationsRemoteDataSource {
  Future<GetReservationsResponse> getReservations({required String id});
}

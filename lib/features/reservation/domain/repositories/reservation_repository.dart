import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/entities/get_reservations_response.dart';

abstract class ReservationsRepository {
  const ReservationsRepository();

  ResultFuture<GetReservationsResponse> getReservations({required String id});
}

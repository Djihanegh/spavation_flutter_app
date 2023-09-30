import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/entities/check_coupon_response.dart';
import 'package:spavation/features/reservation/domain/entities/get_reservations_response.dart';

abstract class ReservationsRepository {
  const ReservationsRepository();

  ResultFuture<GetReservationsResponse> getReservations({required String id});

  ResultFuture<CheckCouponResponse> checkCoupon(
      {required String salonId, required String code});
}

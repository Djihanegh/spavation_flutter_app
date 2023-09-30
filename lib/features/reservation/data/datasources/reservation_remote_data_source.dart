import 'package:spavation/features/reservation/domain/entities/check_coupon_response.dart';

import '../../domain/entities/get_reservations_response.dart';

abstract class ReservationsRemoteDataSource {
  Future<GetReservationsResponse> getReservations({required String id});

  Future<CheckCouponResponse> checkCoupon(
      {required String code, required String salonId});
}

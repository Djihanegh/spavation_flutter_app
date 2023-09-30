import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/domain/entities/check_coupon_response.dart';
import '../repositories/reservation_repository.dart';
import 'package:spavation/core/usecase/usecase.dart';

class CheckCouponUseCase
    extends UseCaseWithParams<CheckCouponResponse, DataMap> {
  const CheckCouponUseCase(this._repository);

  final ReservationsRepository _repository;

  @override
  ResultFuture<CheckCouponResponse> call(params) async => _repository
      .checkCoupon(salonId: params['salon_id'], code: params['code']);
}

import 'package:spavation/core/utils/base_response.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/reservation/data/models/coupon_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_coupon_response.g.dart';

@JsonSerializable()
class CheckCouponResponse extends BaseResponse {
  CheckCouponResponse({
    required super.message,
    required super.status,
    required this.copoun,
  });

  final CouponModel copoun;

  factory CheckCouponResponse.fromJson(DataMap json) =>
      _$CheckCouponResponseFromJson(json);

  DataMap toJson() => _$CheckCouponResponseToJson(this);
}

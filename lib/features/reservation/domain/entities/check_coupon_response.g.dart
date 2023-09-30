// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckCouponResponse _$CheckCouponResponseFromJson(Map<String, dynamic> json) =>
    CheckCouponResponse(
      message: json['message'] as String,
      status: json['status'] as bool,
      coupon: CouponModel.fromJson(json['coupon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckCouponResponseToJson(
        CheckCouponResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'coupon': instance.coupon,
    };

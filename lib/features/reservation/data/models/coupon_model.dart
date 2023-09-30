import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/coupon.dart';

class CouponModel extends Coupon {
  const CouponModel(
      {required super.id,
      required super.code,
      required super.discount,
      required super.expireDate,
      required super.salonId,
      required super.status,
      required super.createdAt,
      required super.updatedAt});

  factory CouponModel.fromJson(DataMap source) => CouponModel.fromMap(source);

  CouponModel.fromMap(DataMap json)
      : this(
          id: json["id"],
          code: json["code"],
          discount: json["discount"],
          expireDate: json["expire_date"],
          salonId: json["salon_id"],
          status: json["status"],
          createdAt: json["created_at"],
          updatedAt: json["updated_at"],
        );

  DataMap toMap() => {
        "id": id,
        "code": code,
        "discount": discount,
        "expire_date": expireDate,
        "salon_id": salonId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  String toJson() => jsonEncode(toMap());
}

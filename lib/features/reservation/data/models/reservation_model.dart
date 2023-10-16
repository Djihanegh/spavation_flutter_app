import 'dart:convert';

import 'package:spavation/features/reservation/domain/entities/reservation.dart';
import '../../../../core/utils/typedef.dart';

class ReservationModel extends Reservation {
  const ReservationModel(
      {required super.id,
      required super.createdAt,
      required super.updatedAt,
      required super.status,
      required super.paymentMethod,
      required super.tax,
      required super.total,
      required super.salonId,
      required super.customerId,
      required super.products});

  factory ReservationModel.fromJson(DataMap source) =>
      ReservationModel.fromMap(source);

  ReservationModel.fromMap(DataMap json)
      : this(
            id: json["id"],
            paymentMethod: json["payment_method"],
            tax: json["tax"],
            total: json["total"],
            status: json["status"],
            salonId: json["salon_id"],
            customerId: json["customer_id"],
            createdAt: json["created_at"],
            updatedAt: json["updated_at"],
            products: json['products']);

  DataMap toMap() => {
        "id": id,
        "payment_method": paymentMethod,
        "tax": tax,
        "total": total,
        "status": status,
        "salon_id": salonId,
        "customer_id": customerId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": products
      };

  String toJson() => jsonEncode(toMap());
}

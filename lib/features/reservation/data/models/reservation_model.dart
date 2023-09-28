import 'dart:convert';

import 'package:spavation/features/reservation/domain/entities/reservation.dart';
import '../../../../core/utils/typedef.dart';

class ReservationModel extends Reservation {
  const ReservationModel(
      {required super.id,
      required super.productId,
      required super.reservationId,
      required super.createdAt,
      required super.updatedAt,
      required super.status,
      required super.quantity,
      required super.paymentMethod,
      required super.tax,
      required super.total,
      required super.date,
      required super.time,
      required super.salonId,
      required super.customerId});

  factory ReservationModel.fromJson(DataMap source) =>
      ReservationModel.fromMap(source);

  ReservationModel.fromMap(DataMap json)
      : this(
          id: json["id"],
          reservationId: json["reservation_id"],
          productId: json["product_id"],
          quantity: json["quantity"],
          paymentMethod: json["payment_method"],
          tax: json["tax"],
          total: json["total"],
          status: json["status"],
          date: json["date"],
          time: json["time"],
          salonId: json["salon_id"],
          customerId: json["customer_id"],
          createdAt: json["created_at"],
          updatedAt: json["updated_at"],
        );

  DataMap toMap() => {
        "id": id,
        "reservation_id": reservationId,
        "product_id": productId,
        "quantity": quantity,
        "payment_method": paymentMethod,
        "tax": tax,
        "total": total,
        "status": status,
        "date": date,
        "time": time,
        "salon_id": salonId,
        "customer_id": customerId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  String toJson() => jsonEncode(toMap());
}

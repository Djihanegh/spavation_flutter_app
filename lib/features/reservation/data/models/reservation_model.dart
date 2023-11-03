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
      required super.taxRate,
      required super.logo,
      required super.serviceFee,
      required super.taxNumber,
      required super.totalTax,
      required super.total,
      required super.salonId,
      required super.customerId,
      required super.salonName,
      required super.products});

  factory ReservationModel.fromJson(DataMap source) =>
      ReservationModel.fromMap(source);

  ReservationModel.fromMap(DataMap json)
      : this(
            id: json["id"],
            salonName: json["salon_name"] ?? "",
            paymentMethod: json["payment_method"],
            taxRate: json["tax_rate"] ?? "",
            taxNumber: json["tax_number"] ?? "",
            logo: json["logo"] ?? "",
            serviceFee: json["service_fee"] ?? "",
            totalTax: json["total_tax"] ?? "",
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
        "taxRate": taxRate,
        "taxNumber": taxNumber,
        "logo": logo,
        "serviceFee": serviceFee,
        "totalTax": totalTax,
        "total": total,
        "status": status,
        "salon_id": salonId,
        "customer_id": customerId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": products,
        "salon_name": salonName
      };

  String toJson() => jsonEncode(toMap());
}

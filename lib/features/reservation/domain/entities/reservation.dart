import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  const Reservation(
      {required this.id,
      required this.productId,
      required this.reservationId,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      required this.quantity,
      required this.paymentMethod,
      required this.tax,
      required this.total,
      required this.date,
      required this.time,
      required this.salonId,
      required this.customerId,
      required this.products});

  final int id;
  final String reservationId;
  final String productId;
  final String products;
  final String createdAt;
  final String updatedAt;
  final String quantity;
  final String paymentMethod;
  final String tax;
  final String total;
  final String status;
  final String date;
  final String time;
  final String salonId;
  final String customerId;

  @override
  List<Object> get props => [
        id,
        reservationId,
        productId,
        createdAt,
        updatedAt,
        quantity,
        paymentMethod,
        tax,
        total,
        status,
        date,
        time,
        salonId,
        customerId,
        products
      ];
}

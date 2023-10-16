import 'package:equatable/equatable.dart';
import 'package:spavation/core/utils/typedef.dart';

class Reservation extends Equatable {
  const Reservation(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      required this.paymentMethod,
      required this.tax,
      required this.total,
      required this.salonId,
      required this.customerId,
      required this.products});

  final int id;
  final List products;
  final String createdAt;
  final String updatedAt;
  final String paymentMethod;
  final String tax;
  final String total;
  final String status;
  final String salonId;
  final String customerId;

  @override
  List<Object> get props => [
        id,
        createdAt,
        updatedAt,
        paymentMethod,
        tax,
        total,
        status,
        salonId,
        customerId,
        products
      ];
}

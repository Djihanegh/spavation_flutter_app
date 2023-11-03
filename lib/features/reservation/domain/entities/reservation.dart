import 'package:equatable/equatable.dart';
import 'package:spavation/core/utils/typedef.dart';

class Reservation extends Equatable {
  const Reservation(
      {required this.id,
      required this.salonName,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      required this.paymentMethod,
      required this.taxNumber,
      required this.total,
      required this.salonId,
      required this.customerId,
      required this.taxRate,
      required this.logo,
      required this.serviceFee,
      required this.totalTax,
      required this.products});

  final int id;
  final List products;
  final String createdAt;
  final String updatedAt;
  final String paymentMethod;
  final String taxRate;
  final String total;
  final String status;
  final String salonId;
  final String customerId;
  final String logo;
  final String taxNumber;
  final String totalTax;
  final String serviceFee;
  final String salonName;

  @override
  List<Object> get props => [
        id,
        createdAt,
        updatedAt,
        paymentMethod,
        taxNumber,
        taxRate,
        totalTax,
        logo,
        serviceFee,
        total,
        status,
        salonId,
        customerId,
        products,
        salonName
      ];
}

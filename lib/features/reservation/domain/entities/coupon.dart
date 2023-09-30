import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  const Coupon(
      {required this.id,
      required this.code,
      required this.discount,
      required this.expireDate,
      required this.salonId,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  final int id;
  final String code;
  final String discount;
  final DateTime expireDate;
  final String salonId;
  final String status;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object> get props => [
        id,
        code,
        discount,
        expireDate,
        salonId,
        status,
        createdAt,
        updatedAt,
      ];
}

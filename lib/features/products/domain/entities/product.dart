import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.image,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.price,
    required this.salonId,
    required this.categoryId,
    required this.description,
    required this.timeFrom,
    required this.timeTo,
    required this.dateFrom,
    required this.dateTo,
    required this.discount,
  });

  final int id;
  final String image;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String price;
  final String salonId;
  final String categoryId;
  final String description;
  final String timeFrom;
  final String timeTo;
  final String dateFrom;
  final String dateTo;
  final String discount;

  @override
  List<Object> get props =>
      [
        id,
        image,
        name,
        createdAt,
        updatedAt,
        status,
        price,
        salonId,
        categoryId,
        description,
        timeFrom,
        timeTo,
        dateFrom,
        dateTo,
        discount,
      ];
}

import 'package:equatable/equatable.dart';

class Salon extends Equatable {
  Salon(
      {required this.id,
      required this.image,
      required this.name,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.phone,
      required this.email,
      required this.description,
      required this.descriptionAr,
      required this.openTime,
      required this.closeTime,
      required this.openDay,
      required this.closeDay,
      required this.userId,
      required this.isForMale,
      required this.isForFemale,
      required this.isDiscount,
      required this.rate,
      required this.discount,
      required this.distance,
      required this.taxNumber,
      required this.taxRate,
      required this.categoryId,
      required this.city});

  final int id;
  final String image;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String address;
  final String latitude;
  final String longitude;
  final String phone;
  final String email;
  final String description;
  final String descriptionAr;
  final String openTime;
  final String closeTime;
  final String openDay;
  final String closeDay;
  final String userId;
  final int isForMale;
  final int isForFemale;
  final String isDiscount;
  final int rate;
  final String discount;
  final String taxNumber;
  final String taxRate;
  final String city;
  final String categoryId;
  double distance;

  @override
  List<Object> get props => [
        id,
        image,
        name,
        createdAt,
        updatedAt,
        status,
        address,
        latitude,
        longitude,
        phone,
        email,
        description,
        descriptionAr,
        openTime,
        closeTime,
        openDay,
        closeDay,
        userId,
        isForMale,
        isForFemale,
        isDiscount,
        rate,
        discount,
        distance,
        taxNumber,
        taxRate,
        city,
        categoryId
      ];
}

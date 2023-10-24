import 'package:equatable/equatable.dart';

class Salon extends Equatable {
   Salon({
    required this.id,
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
    required this.distance
  });

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
  final String openTime;
  final String closeTime;
  final String openDay;
  final String closeDay;
  final String userId;
  final String isForMale;
  final String isForFemale;
  final String isDiscount;
  final String rate;
  final String discount;
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
        distance
      ];
}

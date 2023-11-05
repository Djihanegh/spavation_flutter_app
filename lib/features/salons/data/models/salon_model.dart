import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/salon.dart';

class SalonModel extends Salon {
  SalonModel(
      {required super.id,
      required super.image,
      required super.name,
      required super.createdAt,
      required super.updatedAt,
      required super.status,
      required super.address,
      required super.latitude,
      required super.longitude,
      required super.phone,
      required super.email,
      required super.description,
      required super.openTime,
      required super.closeTime,
      required super.openDay,
      required super.closeDay,
      required super.userId,
      required super.isForMale,
      required super.isForFemale,
      required super.isDiscount,
      required super.rate,
      required super.discount,
      required super.distance,
      required super.categoryId,
      required super.taxNumber,
      required super.taxRate,
      required super.city});

  factory SalonModel.fromJson(DataMap source) => SalonModel.fromMap(source);

  SalonModel.fromMap(DataMap json)
      : this(
            id: json["id"],
            name: json["name"],
            address: json["address"],
            latitude: json["latitude"],
            longitude: json["longitude"],
            phone: json["phone"],
            email: json["email"],
            description: json["description"],
            image: json["image"],
            openTime: json["open_time"],
            closeTime: json["close_time"],
            openDay: json["open_day"] as String,
            closeDay: json["close_day"] as String,
            status: json["status"],
            userId: json["user_id"],
            isForMale: json["is_for_male"],
            isForFemale: json["is_for_female"],
            isDiscount: json["is_discount"],
            discount: json["discount"],
            rate: json["rate"],
            createdAt: json["created_at"] as String,
            updatedAt: json["updated_at"] as String,
            taxNumber: json['tax_number'],
            taxRate: json['tax_rate'],
            city: json["city"],
            categoryId: json["category_id"],
            distance: 0.0);

  DataMap toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "phone": phone,
        "email": email,
        "description": description,
        "image": image,
        "open_time": openTime,
        "close_time": closeTime,
        "open_day": "",
        "close_day": "",
        "status": status,
        "user_id": userId,
        "is_for_male": isForMale,
        "is_for_female": isForFemale,
        "is_discount": isDiscount,
        "discount": discount,
        "rate": rate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "distance": 0.0,
        "city": city,
        "category_id": categoryId
      };

  String toJson() => jsonEncode(toMap());

  void setDistance(double dist) {
    distance = dist;
  }
}

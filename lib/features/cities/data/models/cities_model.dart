import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/cities.dart';

class CitiesModel extends City {
  const CitiesModel({
    required super.id,
    required super.nameAr,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required super.latitude,
    required super.longitude,
  });

  factory CitiesModel.fromJson(DataMap source) => CitiesModel.fromMap(source);

  CitiesModel.fromMap(DataMap json)
      : this(
          id: json["id"],
          name: json["name"],
          latitude: json["latitude"],
          longitude: json["longitude"],
          nameAr: json["name_ar"],
          createdAt: json["created_at"] as String,
          updatedAt: json["updated_at"] as String,
        );

  DataMap toMap() => {
        "id": id,
        "name": name,
        "longitude": longitude,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "name_ar": nameAr
      };

  String toJson() => jsonEncode(toMap());
}

import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/banner.dart';

class BannerModel extends Banner {
  const BannerModel(
      {required super.id,
      required super.image,
      required super.name,
      required super.createdAt,
      required super.updatedAt,
      required super.status,
      required super.salonId});

  factory BannerModel.fromJson(DataMap source) => BannerModel.fromMap(source);

  BannerModel.fromMap(DataMap map)
      : this(
            name: map['name'] as String,
            id: map['id'] as int,
            image: map['image'] as String,
            updatedAt: map['updated_at'] as String,
            createdAt: map['created_at'] as String,
            status: map['status'] as String,
            salonId: map['salon_id'] as String);

  DataMap toMap() => {
        'name': name,
        'image': image,
        'id': id,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'status': status,
        'salon_id': salonId
      };

  String toJson() => jsonEncode(toMap());
}

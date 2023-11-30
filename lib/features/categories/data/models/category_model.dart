import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel(
      {required super.id,
      required super.image,
      required super.name,
      required super.createdAt,
      required super.updatedAt,
      required super.nameAr,
      required super.status});

  factory CategoryModel.fromJson(DataMap source) =>
      CategoryModel.fromMap(source);

  CategoryModel.fromMap(DataMap map)
      : this(
            name: map['name'] ?? '',
            nameAr: map['name_ar'] ?? '',
            id: map['id'] as int,
            image: map['image'] ?? '',
            updatedAt: map['updated_at'] ?? '',
            createdAt: map['created_at'] ?? '',
            status: map['status'] ?? '');

  DataMap toMap() => {
        'name': name,
        'name_ar': nameAr,
        'image': image,
        'id': id,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'status': status
      };

  String toJson() => jsonEncode(toMap());
}

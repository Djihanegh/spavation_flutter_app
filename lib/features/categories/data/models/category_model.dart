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
      required super.status});

  factory CategoryModel.fromJson(DataMap source) =>
      CategoryModel.fromMap(source);

  CategoryModel.fromMap(DataMap map)
      : this(
            name: map['name'] as String,
            id: map['id'] as int,
            image: map['image'] as String,
            updatedAt: map['updated_at'] as String,
            createdAt: map['created_at'] as String,
            status: map['status'] as String);

  DataMap toMap() => {
        'name': name,
        'image': image,
        'id': id,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'status': status
      };

  String toJson() => jsonEncode(toMap());
}

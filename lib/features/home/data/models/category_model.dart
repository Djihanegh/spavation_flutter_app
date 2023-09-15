import 'dart:convert';

import 'package:spavation/features/home/domain/entities/category.dart';

import '../../../../core/utils/typedef.dart';

class CategoryModel extends Category {
  const CategoryModel(
      {required super.id, required super.image, required super.name});

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(jsonDecode(source) as DataMap);

  CategoryModel.fromMap(DataMap map)
      : this(
            name: map['name'] as String,
            id: map['id'] as int,
            image: map['image'] as String);

  CategoryModel.loginUserModel(CategoryModel category)
      : this(name: category.name, image: category.image, id: category.id);

  DataMap toMap() => {'name': name, 'image': image, 'id': id};

  String toJson() => jsonEncode(toMap());
}

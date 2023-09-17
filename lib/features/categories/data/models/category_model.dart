import 'dart:convert';


import '../../../../core/utils/typedef.dart';
import '../../domain/entities/category.dart';

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


  DataMap toMap() => {'name': name, 'image': image, 'id': id};

  String toJson() => jsonEncode(toMap());
}

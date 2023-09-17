// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoryResponse _$GetCategoryResponseFromJson(Map<String, dynamic> json) =>
    GetCategoryResponse(
      (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as int,
    );

Map<String, dynamic> _$GetCategoryResponseToJson(
        GetCategoryResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'status': instance.status,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_salons_by_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSalonsByCategoryResponse _$GetSalonsByCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetSalonsByCategoryResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => SalonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSalonsByCategoryResponseToJson(
        GetSalonsByCategoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

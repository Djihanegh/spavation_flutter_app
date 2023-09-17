// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_salons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSalonsResponse _$GetSalonsResponseFromJson(Map<String, dynamic> json) =>
    GetSalonsResponse(
      (json['salons'] as List<dynamic>?)
          ?.map((e) => SalonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSalonsResponseToJson(GetSalonsResponse instance) =>
    <String, dynamic>{
      'salons': instance.salons,
    };

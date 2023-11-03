// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCitiesResponse _$GetCitiesResponseFromJson(Map<String, dynamic> json) =>
    GetCitiesResponse(
      (json['cities'] as List<dynamic>?)
          ?.map((e) => CitiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCitiesResponseToJson(GetCitiesResponse instance) =>
    <String, dynamic>{
      'cities': instance.cities,
    };

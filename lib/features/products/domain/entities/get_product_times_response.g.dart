// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_times_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductTimesResponse _$GetProductTimesResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductTimesResponse(
      (json['timeIntervals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['status'] as int,
      json['message'] as String?,
    );

Map<String, dynamic> _$GetProductTimesResponseToJson(
        GetProductTimesResponse instance) =>
    <String, dynamic>{
      'timeIntervals': instance.timeIntervals,
      'message': instance.message,
      'status': instance.status,
    };

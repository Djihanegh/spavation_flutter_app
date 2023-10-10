// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_reservation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReservationResponse _$AddReservationResponseFromJson(
        Map<String, dynamic> json) =>
    AddReservationResponse(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AddReservationResponseToJson(
        AddReservationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

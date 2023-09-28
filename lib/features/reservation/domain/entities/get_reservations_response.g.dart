// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_reservations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReservationsResponse _$GetReservationsResponseFromJson(
        Map<String, dynamic> json) =>
    GetReservationsResponse(
      message: json['message'] as String,
      status: json['status'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => ReservationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetReservationsResponseToJson(
        GetReservationsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'data': instance.data,
    };

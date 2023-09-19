// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDetailsResponse _$GetUserDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserDetailsResponse(
      message: json['message'] as String,
      status: json['status'] as bool,
      Customers: json['Customers'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GetUserDetailsResponseToJson(
        GetUserDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'Customers': instance.Customers,
    };

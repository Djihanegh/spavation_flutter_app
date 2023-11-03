// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOtpResponse _$CheckOtpResponseFromJson(Map<String, dynamic> json) =>
    CheckOtpResponse(
      json['token'] as String,
      message: json['message'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$CheckOtpResponseToJson(CheckOtpResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'token': instance.token,
    };

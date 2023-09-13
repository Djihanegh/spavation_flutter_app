// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendOtpResponse _$ResendOtpResponseFromJson(Map<String, dynamic> json) =>
    ResendOtpResponse(
      json['otp'] as int,
      message: json['message'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$ResendOtpResponseToJson(ResendOtpResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'otp': instance.otp,
    };

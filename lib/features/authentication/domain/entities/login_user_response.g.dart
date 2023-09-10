// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserResponse _$LoginUserResponseFromJson(Map<String, dynamic> json) =>
    LoginUserResponse(
      json['token'] as String,
      json['email'] as String,
      json['name'] as String,
      message: json['message'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$LoginUserResponseToJson(LoginUserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'token': instance.token,
      'email': instance.email,
      'name': instance.name,
    };

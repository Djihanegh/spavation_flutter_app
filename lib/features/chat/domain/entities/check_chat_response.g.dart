// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckChatResponse _$CheckChatResponseFromJson(Map<String, dynamic> json) =>
    CheckChatResponse(
      json['message'] as String,
      json['ticket'] as int,
    );

Map<String, dynamic> _$CheckChatResponseToJson(CheckChatResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'ticket': instance.ticket,
    };

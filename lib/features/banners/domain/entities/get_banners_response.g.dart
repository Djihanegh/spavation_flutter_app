// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_banners_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBannersResponse _$GetBannersResponseFromJson(Map<String, dynamic> json) =>
    GetBannersResponse(
      (json['banners'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as int,
    );

Map<String, dynamic> _$GetBannersResponseToJson(GetBannersResponse instance) =>
    <String, dynamic>{
      'banners': instance.banners,
      'status': instance.status,
    };

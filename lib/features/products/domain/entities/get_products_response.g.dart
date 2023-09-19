// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsResponse _$GetProductsResponseFromJson(Map<String, dynamic> json) =>
    GetProductsResponse(
      (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as int,
    );

Map<String, dynamic> _$GetProductsResponseToJson(
        GetProductsResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
      'status': instance.status,
    };

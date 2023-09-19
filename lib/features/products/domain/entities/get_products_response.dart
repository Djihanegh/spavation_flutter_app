import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/product_model.dart';

part 'get_products_response.g.dart';

@JsonSerializable()
class GetProductsResponse {
  GetProductsResponse(
    this.products,
    this.status,
  );

  final List<ProductModel>? products;
  final int status;

  factory GetProductsResponse.fromJson(DataMap json) =>
      _$GetProductsResponseFromJson(json);

  DataMap toJson() => _$GetProductsResponseToJson(this);
}

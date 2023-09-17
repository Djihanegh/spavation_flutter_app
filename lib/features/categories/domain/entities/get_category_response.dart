import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/category_model.dart';

part 'get_category_response.g.dart';

@JsonSerializable()
class GetCategoryResponse extends BaseResponse {
  GetCategoryResponse(this.data,
      {required super.message, required super.status});

  final List<CategoryModel>? data;

  factory GetCategoryResponse.fromJson(DataMap json) =>
      _$GetCategoryResponseFromJson(json);

  DataMap toJson() => _$GetCategoryResponseToJson(this);
}

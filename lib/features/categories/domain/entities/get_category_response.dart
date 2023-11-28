import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/category_model.dart';

part 'get_category_response.g.dart';

@JsonSerializable()
class GetCategoryResponse {
  GetCategoryResponse(
    this.categories,
    this.status,
  );

  final List<CategoryModel>? categories;
  final int status;

  factory GetCategoryResponse.fromJson(DataMap json) =>
      _$GetCategoryResponseFromJson(json);

  DataMap toJson() => _$GetCategoryResponseToJson(this);
}

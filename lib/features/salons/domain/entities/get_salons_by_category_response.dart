import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/salon_model.dart';

part 'get_salons_by_category_response.g.dart';

@JsonSerializable()
class GetSalonsByCategoryResponse {
  GetSalonsByCategoryResponse(
    this.data,
  );

  final List<SalonModel>? data;

  factory GetSalonsByCategoryResponse.fromJson(DataMap json) =>
      _$GetSalonsByCategoryResponseFromJson(json);

  DataMap toJson() => _$GetSalonsByCategoryResponseToJson(this);
}

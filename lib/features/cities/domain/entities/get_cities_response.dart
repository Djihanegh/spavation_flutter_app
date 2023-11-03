import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/cities_model.dart';

part 'get_cities_response.g.dart';

@JsonSerializable()
class GetCitiesResponse {
  GetCitiesResponse(
    this.cities,
  );

  final List<CitiesModel>? cities;

  factory GetCitiesResponse.fromJson(DataMap json) =>
      _$GetCitiesResponseFromJson(json);

  DataMap toJson() => _$GetCitiesResponseToJson(this);
}

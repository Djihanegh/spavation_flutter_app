import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/salon_model.dart';

part 'get_salons_response.g.dart';

@JsonSerializable()
class GetSalonsResponse {
  GetSalonsResponse(
    this.salons,
  );

  final List<SalonModel>? salons;

  factory GetSalonsResponse.fromJson(DataMap json) =>
      _$GetSalonsResponseFromJson(json);

  DataMap toJson() => _$GetSalonsResponseToJson(this);


}

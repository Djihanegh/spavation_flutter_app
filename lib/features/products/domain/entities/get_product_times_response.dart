import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';


part 'get_product_times_response.g.dart';

@JsonSerializable()
class GetProductTimesResponse {
  GetProductTimesResponse(
    this.timeIntervals,
    this.status,
  );

  final List<String>? timeIntervals;
  final int status;

  factory GetProductTimesResponse.fromJson(DataMap json) =>
      _$GetProductTimesResponseFromJson(json);

  DataMap toJson() => _$GetProductTimesResponseToJson(this);
}

import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

part 'add_reservation_response.g.dart';

@JsonSerializable()
class AddReservationResponse extends BaseResponse {
  AddReservationResponse({
    required super.message,
    required super.status,
    required this.data,
  });

  final DataMap data;

  factory AddReservationResponse.fromJson(DataMap json) =>
      _$AddReservationResponseFromJson(json);

  DataMap toJson() => _$AddReservationResponseToJson(this);
}

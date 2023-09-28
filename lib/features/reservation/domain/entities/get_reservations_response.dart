import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

import '../../data/models/reservation_model.dart';

part 'get_reservations_response.g.dart';

@JsonSerializable()
class GetReservationsResponse extends BaseResponse {
  GetReservationsResponse({
    required super.message,
    required super.status,
    required this.data,
  });

  final List<ReservationModel> data;

  factory GetReservationsResponse.fromJson(DataMap json) =>
      _$GetReservationsResponseFromJson(json);

  DataMap toJson() => _$GetReservationsResponseToJson(this);
}

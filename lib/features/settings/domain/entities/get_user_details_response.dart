import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

part 'get_user_details_response.g.dart';

@JsonSerializable()
class GetUserDetailsResponse extends BaseResponse {
  GetUserDetailsResponse({
    required super.message,
    required super.status,
    required this.customers,
  });

  final String customers;

  factory GetUserDetailsResponse.fromJson(DataMap json) =>
      _$GetUserDetailsResponseFromJson(json);

  DataMap toJson() => _$GetUserDetailsResponseToJson(this);
}

import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

part 'get_user_response.g.dart';

@JsonSerializable()
class GetUserResponse extends BaseResponse {
  GetUserResponse(this.user, {required super.message, required super.status});

  final DataMap user;

  factory GetUserResponse.fromJson(DataMap json) =>
      _$GetUserResponseFromJson(json);

  DataMap toJson() => _$GetUserResponseToJson(this);
}

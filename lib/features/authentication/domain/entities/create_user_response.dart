import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

part 'create_user_response.g.dart';

@JsonSerializable()
class CreateUserResponse extends BaseResponse {
  CreateUserResponse(this.token,
      {required super.message, required super.status});

  final String token;

  factory CreateUserResponse.fromJson(DataMap json) =>
      _$CreateUserResponseFromJson(json);

  DataMap toJson() => _$CreateUserResponseToJson(this);
}

import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

part 'login_user_response.g.dart';

@JsonSerializable()
class LoginUserResponse extends BaseResponse {
  LoginUserResponse(this.email, this.name,
      {required super.message, required super.status});

  final String email;
  final String name;

  factory LoginUserResponse.fromJson(DataMap json) =>
      _$LoginUserResponseFromJson(json);

  DataMap toJson() => _$LoginUserResponseToJson(this);
}

import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

part 'check_otp_response.g.dart';

@JsonSerializable()
class CheckOtpResponse extends BaseResponse {
  CheckOtpResponse(this.token, {required super.message, required super.status});

  final String token;

  factory CheckOtpResponse.fromJson(DataMap json) =>
      _$CheckOtpResponseFromJson(json);

  DataMap toJson() => _$CheckOtpResponseToJson(this);
}

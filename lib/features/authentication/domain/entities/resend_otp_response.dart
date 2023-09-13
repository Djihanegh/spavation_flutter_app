import 'package:spavation/core/utils/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spavation/core/utils/typedef.dart';

part 'resend_otp_response.g.dart';

@JsonSerializable()
class ResendOtpResponse extends BaseResponse {
  ResendOtpResponse(this.otp, {required super.message, required super.status});

  final int otp;

  factory ResendOtpResponse.fromJson(DataMap json) =>
      _$ResendOtpResponseFromJson(json);

  DataMap toJson() => _$ResendOtpResponseToJson(this);
}

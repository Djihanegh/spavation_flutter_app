import 'package:spavation/core/utils/typedef.dart';

class BaseResponse {
  String message;
  bool status;

  BaseResponse({required this.message, required this.status});

  factory BaseResponse.fromJson(DataMap json) {
    return BaseResponse(status: json["status"], message: json["message"]);
  }
}

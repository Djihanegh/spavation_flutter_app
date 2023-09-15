import 'dart:convert';

import 'package:spavation/core/utils/typedef.dart';

class BaseResponse {
  String message;
  bool status;

  BaseResponse({required this.message, required this.status});

  factory BaseResponse.fromJson(String json) {
    return BaseResponse.fromMap(jsonDecode(json) as DataMap);
  }



  BaseResponse.fromMap(DataMap map)
      : this(
          message: map['message'] as String,
          status: map['status'] as bool,
        );

  DataMap toMap() => {'name': message, 'status': status};
}

import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/typedef.dart';

part 'check_chat_response.g.dart';

@JsonSerializable()
class CheckChatResponse {
  CheckChatResponse(this.message, this.ticket);

  final String message;
  final int ticket;

  factory CheckChatResponse.fromJson(DataMap json) =>
      _$CheckChatResponseFromJson(json);

  DataMap toJson() => _$CheckChatResponseToJson(this);
}

import 'dart:convert';

import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/chat/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel(
      {required super.message,
      required super.userName,
      required super.userEmail,
      required super.userImage,
      required super.createdAt,
      required super.id,
      required super.userId,
      required super.ticket,
      required super.updatedAt,
      required super.isImage});

  factory MessageModel.fromJson(DataMap json) => MessageModel(
        id: json["id"],
        userId: json["user_id"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ticket: json["ticket"],
        isImage: json["is_image"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userImage: json["user_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ticket": ticket,
        "is_image": isImage,
        "user_name": userName,
        "user_email": userEmail,
        "user_image": userImage,
      };

 static  List<Message> messagesFromJson(String str) =>
      List<Message>.from(json.decode(str).map((x) => MessageModel.fromJson(x)));

  String messagesToJson(List<Message> data) =>
      jsonEncode(List<dynamic>.from(data.map((x) => toJson())));
}

import 'dart:convert';

List<Messages> messagesFromJson(String str) => List<Messages>.from(json.decode(str).map((x) => Messages.fromJson(x)));

String messagesToJson(List<Messages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Messages {
  int? id;
  String? userId;
  String message;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? ticket;
  String? isImage;
  dynamic userName;
  dynamic userEmail;
  dynamic userImage;

  Messages({
    this.id,
    this.userId,
    required this.message,
    this.createdAt,
    this.updatedAt,
    this.ticket,
    this.isImage,
    required this.userName,
    required this.userEmail,
    required this.userImage,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
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
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "ticket": ticket,
    "is_image": isImage,
    "user_name": userName,
    "user_email": userEmail,
    "user_image": userImage,
  };
}

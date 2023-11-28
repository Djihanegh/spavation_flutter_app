import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int id;
  final String userId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String ticket;
  final String isImage;
  final dynamic userName;
  final dynamic userEmail;
  final dynamic userImage;

  const Message({
    required   this.id,
    required  this.userId,
    required this.message,
    required  this.createdAt,
    required  this.updatedAt,
    required  this.ticket,
    required this.isImage,
    required this.userName,
    required this.userEmail,
    required this.userImage,
  });

  @override
  List<Object?> get props => [
        id,
        userEmail,
        userId,
        userImage,
        userName,
        createdAt,
        updatedAt,
        isImage,
        ticket,
        message
      ];
}

import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final bool isUser;
  final String message;
  final bool likeMessage;
  final bool dislikeMessage;
  final DateTime createAt;

  const Message({
    required this.isUser,
    required this.message,
    required this.createAt,
    required this.id,
    required this.likeMessage,
    required this.dislikeMessage,
  });

  @override
  List<Object?> get props =>
      [id, isUser, message, createAt, dislikeMessage, likeMessage];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'isUser': isUser,
        'message': message,
        'createAt': createAt,
        'likeMessage': likeMessage,
        'dislikeMessage': dislikeMessage,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      isUser: json['isUser'],
      createAt: json['createAt'],
      id: json['id'],
      message: json['message'],
      dislikeMessage: json['dislikeMessage'],
      likeMessage: json['likeMessage']);
}

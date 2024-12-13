import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final bool isUser;
  final String message;
  final DateTime createAt;

  const Message({
    required this.isUser,
    required this.message,
    required this.createAt,
    required this.id,
  });

  @override
  List<Object?> get props => [id, isUser, message, createAt];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'isUser': isUser,
        'message': message,
        'createAt': createAt,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        isUser: json['isUser'],
        createAt: json['createAt'],
        id: json['id'],
        message: json['message'],
      );
}

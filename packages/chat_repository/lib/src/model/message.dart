// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final bool isUser;
  final String message;
  final bool likeMessage;
  final bool dislikeMessage;
  final DateTime? createAt;

  const Message({
    required this.isUser,
    required this.message,
    required this.createAt,
    required this.id,
    required this.likeMessage,
    required this.dislikeMessage,
  });

  static const Message emptyMessage = Message(
      id: '',
      isUser: true,
      message: '',
      createAt: null,
      likeMessage: false,
      dislikeMessage: false);

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
      createAt: (json['createAt'] as Timestamp).toDate(),
      id: json['id'],
      message: json['message'],
      dislikeMessage: json['dislikeMessage'],
      likeMessage: json['likeMessage']);

  Message copyWith({
    String? id,
    bool? isUser,
    String? message,
    bool? likeMessage,
    bool? dislikeMessage,
    DateTime? createAt,
  }) {
    return Message(
      id: id ?? this.id,
      isUser: isUser ?? this.isUser,
      message: message ?? this.message,
      likeMessage: likeMessage ?? this.likeMessage,
      dislikeMessage: dislikeMessage ?? this.dislikeMessage,
      createAt: createAt ?? this.createAt,
    );
  }
}

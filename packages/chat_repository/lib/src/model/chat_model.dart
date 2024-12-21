import 'package:chat_repository/src/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String id;
  final DateTime? createAt;
  final DateTime? updateAt;
  final String chatName;
  final List<Message> messages;
  final String userCreatorChat;

  static const ChatModel emptyChatModel = ChatModel(
      id: '',
      createAt: null,
      updateAt: null,
      chatName: '',
      messages: [],
      userCreatorChat: '');

  const ChatModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.chatName,
      required this.userCreatorChat,
      required this.messages});

  @override
  List<Object?> get props =>
      [createAt, updateAt, chatName, messages, userCreatorChat];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'createAt': createAt,
        'updateAt': updateAt,
        'chatName': chatName,
        'userCreatorChat': userCreatorChat,
        'messages': messages.map((message) => message.toJson())
      };

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      messages:
          (json['messages'] as List).map((e) => Message.fromJson(e)).toList(),
      id: json['id'] as String,
      userCreatorChat: json['userCreatorChat'] as String,
      createAt: (json['createAt'] as Timestamp).toDate(),
      updateAt: (json['updateAt'] as Timestamp).toDate(),
      chatName: json['chatName'] as String,
    );
  }

  ChatModel copyWith({
    String? id,
    DateTime? createAt,
    DateTime? updateAt,
    String? chatName,
    List<Message>? messages,
    String? userCreatorChat,
  }) {
    return ChatModel(
      id: id ?? this.id,
      userCreatorChat: userCreatorChat ?? this.userCreatorChat,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      chatName: chatName ?? this.chatName,
      messages: messages ?? this.messages,
    );
  }
}

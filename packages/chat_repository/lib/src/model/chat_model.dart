// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_repository/src/model/message.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String id;
  final DateTime? createAt;
  final DateTime? updateAt;
  final String chatName;
  final List<Message> messages;

  static const ChatModel emptyChatModel = ChatModel(
      id: '', createAt: null, updateAt: null, chatName: '', messages: []);

  const ChatModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.chatName,
      required this.messages});

  @override
  List<Object?> get props => [createAt, updateAt, chatName, messages];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'createAt': createAt,
        'updateAt': updateAt,
        'chatName': chatName,
        'messages': messages.map((message) => message.toJson())
      };

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
      updateAt: json['updateAt'],
      createAt: json['createAt'],
      id: json['id'],
      chatName: json['chatName'],
      messages: json['messages']);

  ChatModel copyWith({
    String? id,
    DateTime? createAt,
    DateTime? updateAt,
    String? chatName,
    List<Message>? messages,
  }) {
    return ChatModel(
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      chatName: chatName ?? this.chatName,
      messages: messages ?? this.messages,
    );
  }
}

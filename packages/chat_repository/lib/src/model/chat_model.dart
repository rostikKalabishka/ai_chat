import 'package:chat_repository/src/model/message.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String id;
  final DateTime createAt;
  final DateTime updateAt;
  final String chatName;
  final List<Message> messages;

  const ChatModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.chatName,
      required this.messages});

  @override
  List<Object?> get props => [createAt, updateAt, chatName, messages];
}

import 'package:chat_repository/chat_repository.dart';
import 'package:chat_repository/src/model/message.dart';

abstract interface class AbstractChatRepository {
  Future<void> createChat({required List<Message> messageForNewChat});

  Future<void> updateChat({required List<Message> messageForNewChat});

  Future<void> sendMessage(
      {required ChatModel chatModel, required Message userMessage});

  Future<void> getChat({required String chatId});

  Future<void> deleteChat({required String chatId});
}

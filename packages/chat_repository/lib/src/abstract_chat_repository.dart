import 'package:chat_repository/chat_repository.dart';
import 'package:chat_repository/src/model/message.dart';

abstract interface class AbstractChatRepository {
  Future<ChatModel> createChat({required String userCreatorChat});

  Future<void> updateChat({required ChatModel chatModel});

  Future<void> sendMessage(
      {required ChatModel chatModel, required Message userMessage});

  Future<void> getChat({required String chatId});

  Future<void> deleteChat({required String chatId});

  Future<List<ChatModel>> getHistoryCurrentUser({required String userId});

  Future<List<ChatModel>> searchChat(
      {required String userId, required String query});
}

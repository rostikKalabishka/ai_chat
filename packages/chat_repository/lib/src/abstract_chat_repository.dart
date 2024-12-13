import 'package:chat_repository/src/model/message.dart';

abstract interface class AbstractChatRepository {
  Future<void> createChat({required List<Message> messageForNewChat});

  Future<void> updateChat({required List<Message> messageForNewChat});

  Future<void> getResponse({required Message message});
}

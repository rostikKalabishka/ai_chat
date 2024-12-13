import 'package:chat_repository/src/abstract_chat_repository.dart';
import 'package:chat_repository/src/model/message.dart';

class ChatRepository implements AbstractChatRepository {
  @override
  Future<void> createChat({required List<Message> messageForNewChat}) async {}

  @override
  Future<void> getResponse({required Message message}) {
    // TODO: implement getResponse
    throw UnimplementedError();
  }

  @override
  Future<void> updateChat({required List<Message> messageForNewChat}) {
    // TODO: implement updateChat
    throw UnimplementedError();
  }
}

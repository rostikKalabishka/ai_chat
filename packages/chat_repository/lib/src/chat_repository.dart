import 'dart:developer';

import 'package:chat_repository/chat_repository.dart';
import 'package:chat_repository/src/abstract_chat_repository.dart';
import 'package:chat_repository/src/constants/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

class ChatRepository implements AbstractChatRepository {
  final _chatsCollection = FirebaseFirestore.instance.collection('chats');
  late final GenerativeModel _model;
  ChatRepository() {
    _model = GenerativeModel(
      model: '${dotenv.env['MODEL']}',
      apiKey: '${dotenv.env['API_KEY']}',
    );
  }
  @override
  Future<ChatModel> createChat({required String userCreatorChat}) async {
    try {
      final dateTime = DateTime.now();
      final ChatModel chatModel = ChatModel(
        messages: [],
        id: Uuid().v1(),
        createAt: dateTime,
        updateAt: dateTime,
        chatName: '',
        userCreatorChat: userCreatorChat,
      );

      await _chatsCollection.doc(chatModel.id).set(chatModel.toJson());

      final chatSnapshot = await _chatsCollection.doc(chatModel.id).get();

      if (chatSnapshot.exists) {
        final chatData = chatSnapshot.data();
        if (chatData != null) {
          return ChatModel.fromJson(chatData);
        }
      }

      throw Exception('Chat not found or data is null');
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<ChatModel> getChat({required String chatId}) async {
    try {
      final chatDoc = _chatsCollection.doc(chatId);
      final chatData = await chatDoc.get();

      final currentChat = ChatModel.fromJson(chatData.data()!);
      return currentChat;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateChat({required ChatModel chatModel}) async {
    try {
      await _chatsCollection.doc(chatModel.id).update({
        "messages": chatModel.messages.map((message) => message.toJson()),
        "chatName": chatModel.messages[0].message
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Message> sendMessage({
    required ChatModel chatModel,
    required Message userMessage,
  }) async {
    final dateTime = DateTime.now();
    try {
      final context = chatModel.messages
          .map((e) => {"message": e.message, "isUser": e.isUser})
          .toList()
          .join('\n');

      final TextPart prompt = TextPart(Constants.askFilePrompt
          .replaceAll('{{conversationHistory}}', context)
          .replaceAll('{{userMessage}}', userMessage.message));

      final response = await _model.generateContent([
        Content.multi([prompt])
      ]);

      final updateUserMessage = userMessage.copyWith(
          id: Uuid().v4(), createAt: DateTime.now(), isUser: true);

      final responseMessage = Message(
          isUser: false,
          message: response.text ?? 'Don’t have data',
          createAt: dateTime,
          id: Uuid().v4(),
          likeMessage: false,
          dislikeMessage: false);

      final updateChatModel = chatModel.copyWith(messages: [
        ...chatModel.messages,
        updateUserMessage,
        responseMessage
      ]);

      await updateChat(chatModel: updateChatModel);

      return responseMessage;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteChat({required String chatId}) async {
    try {
      await _chatsCollection.doc(chatId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ChatModel>> getHistoryCurrentUser(
      {required String userId}) async {
    try {
      final querySnapshot = await _chatsCollection
          .where("userCreatorChat", isEqualTo: userId)
          // .orderBy('updateAt', descending: true)
          // .orderBy('createAt', descending: true)
          .get();

      final historyData = querySnapshot.docs
          .map((doc) => ChatModel.fromJson(doc.data()))
          .toList();
      return historyData;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ChatModel>> searchChat(
      {required String userId, required String query}) async {
    try {
      final querySnapshot = await _chatsCollection
          .where("userCreatorChat", isEqualTo: userId)
          .get();

      var filteredDocs = querySnapshot.docs
          .where((docs) => docs.data()['chatName'].toString().contains(query));

      return filteredDocs
          .map(
            (doc) => ChatModel.fromJson(doc.data()),
          )
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<ChatModel>> getHistoryStream({required String userId}) {
    try {
      return _chatsCollection
          .where("userCreatorChat", isEqualTo: userId)
          //  .orderBy('updateAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList();
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

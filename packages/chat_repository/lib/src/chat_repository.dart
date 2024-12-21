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
      model: 'gemini-1.5-flash-latest',
      apiKey: '${dotenv.env['API_KEY']}',
    );
  }
  @override
  Future<void> createChat({required List<Message> messageForNewChat}) async {
    try {
      final dateTime = DateTime.now();
      final ChatModel chatModel = ChatModel(
          messages: messageForNewChat,
          id: Uuid().v1(),
          createAt: dateTime,
          updateAt: dateTime,
          chatName: messageForNewChat[0].message);
      await _chatsCollection.doc(chatModel.id).set(chatModel.toJson());
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
  Future<void> updateChat({required List<Message> messageForNewChat}) async {
    try {} catch (e) {
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
      if (chatModel.id.isEmpty) {
        chatModel = chatModel.copyWith(id: Uuid().v4());
      }

      final chatDoc = _chatsCollection.doc(chatModel.id);
      final existingDoc = await chatDoc.get();

      final context =
          chatModel.messages.map((e) => e.toJson()).toList().join('\n');
      log(context);

      final TextPart prompt = TextPart(Constants.askFilePrompt
          .replaceAll('{{conversationHistory}}', context)
          .replaceAll('{{userMessage}}', userMessage.message));

      log('prompt: $prompt');

      final response = await _model.generateContent([
        Content.multi([prompt])
      ]);

      userMessage = userMessage.copyWith(
          id: Uuid().v4(), createAt: DateTime.now(), isUser: true);

      final responseMessage = Message(
          isUser: false,
          message: response.text ?? 'Don’t have data',
          createAt: dateTime,
          id: Uuid().v4(),
          likeMessage: false,
          dislikeMessage: false);

      chatModel = chatModel.copyWith(
          messages: [...chatModel.messages, userMessage, responseMessage]);

      if (!existingDoc.exists) {
        await createChat(messageForNewChat: chatModel.messages);
      }

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
}

import 'dart:developer';

import 'package:chat_repository/chat_repository.dart';
import 'package:chat_repository/src/abstract_chat_repository.dart';
import 'package:chat_repository/src/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

class ChatRepository implements AbstractChatRepository {
  final chatsCollection = FirebaseFirestore.instance.collection('chats');
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
      await chatsCollection.doc(chatModel.id).set(chatModel.toJson());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> getResponse({required Message message}) async {
    try {} catch (e) {
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
  Future<Message> sendMessage(
      {required ChatModel chatModel, required Message userMessage}) async {
    final dateTime = DateTime.now();
    try {
      final context =
          chatModel.messages.map((e) => e.toJson()).toList().join('\n');

      log(context);

      final TextPart prompt =
          TextPart("context:$context, prompt:${userMessage.message}");

      final response = await _model.generateContent([
        Content.multi([prompt])
      ]);

      print(response.text);

      return Message(
          isUser: false,
          message: response.text ?? 'Don`t have date',
          createAt: dateTime,
          id: Uuid().v4(),
          likeMessage: false,
          dislikeMessage: false);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteChat({required String chatId}) async {
    try {
      await chatsCollection.doc(chatId).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

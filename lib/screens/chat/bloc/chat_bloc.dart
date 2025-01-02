import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  final _speechToText = SpeechToText();
  Timer? searchDebounce;
  ChatBloc({required ChatRepository myChatRepository})
      : chatRepository = myChatRepository,
        super(const ChatState()) {
    _initializeSpeechToText();
    on<ChatEvent>((event, emit) async {
      if (event is LoadChatInfo) {
        await _loadChatInfo(event, emit);
      } else if (event is SendMessageInChat) {
        await _sendMessage(event, emit);
      } else if (event is CurrentVoiceListen) {
        await _toggleListening(event, emit);
      }
    });
    on<UpdateVoiceInput>((event, emit) {
      if (event.recognizedWords.isNotEmpty) {
        emit(state.copyWith(currentVoiceInput: event.recognizedWords));
      } else {
        emit(state.copyWith(currentVoiceInput: ''));
      }
    });
  }

  Future<void> _loadChatInfo(
      LoadChatInfo event, Emitter<ChatState> emit) async {
    emit(state.copyWith(chatPageState: LoadChatPageState.loading));
    try {
      final String? chatId = event.chatId;
      if (chatId != null && chatId.isNotEmpty) {
        final ChatModel chatModel =
            await chatRepository.getChat(chatId: chatId);

        emit(state.copyWith(
            chatPageState: LoadChatPageState.loaded,
            chatModel: chatModel,
            userCreatorChatId: event.userId,
            chatId: chatModel.id));
      } else {
        emit(state.copyWith(
          chatId: '',
          chatPageState: LoadChatPageState.loaded,
          chatModel: ChatModel.emptyChatModel,
          userCreatorChatId: event.userId,
        ));
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _sendMessage(
      SendMessageInChat event, Emitter<ChatState> emit) async {
    if (state.chatPageState != LoadChatPageState.loaded) {
      emit(state.copyWith(chatPageState: LoadChatPageState.loading));
    }
    try {
      if (_speechToText.isListening) {
        _speechToText.stop();
        emit(state.copyWith(
          isListening: false,
          currentVoiceInput: '',
        ));
      }

      final chatId = state.chatId;
      late final ChatModel chat;
      if (chatId != null && chatId.isNotEmpty) {
        chat = state.chatModel;
      } else {
        chat = await chatRepository.createChat(
            userCreatorChat: state.userCreatorChatId);
        emit(state.copyWith(
            chatModel: chat,
            chatId: chat.id,
            currentVoiceInput: '',
            isListening: false));
      }

      final Message userMessage = Message.emptyMessage.copyWith(
          message: event.userMessage,
          createAt: DateTime.now(),
          isUser: true,
          id: const Uuid().v4());

      final oldChat = state.chatModel;

      emit(state.copyWith(
          chatModel: state.chatModel
              .copyWith(messages: [...state.chatModel.messages, userMessage]),
          chatPageState: LoadChatPageState.loaded,
          isTyping: true,
          currentVoiceInput: '',
          isListening: false));

      final Message response = await chatRepository.sendMessage(
          chatModel: oldChat, userMessage: userMessage);

      emit(
        state.copyWith(
            chatModel: state.chatModel
                .copyWith(messages: [...state.chatModel.messages, response]),
            chatPageState: LoadChatPageState.loaded,
            isTyping: false,
            currentVoiceInput: '',
            isListening: false),
      );
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _toggleListening(CurrentVoiceListen event, emit) async {
    try {
      if (!state.isListening && _speechToText.isAvailable) {
        emit(state.copyWith(isListening: true, currentVoiceInput: ''));
        _speechToText.listen(
          localeId: PlatformDispatcher.instance.locale.languageCode,
          onResult: (result) {
            add(UpdateVoiceInput(result.recognizedWords));
          },
        );
      } else {
        emit(state.copyWith(isListening: false));
        _speechToText.stop();
      }
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _initializeSpeechToText() async {
    await _speechToText.initialize();
  }
}

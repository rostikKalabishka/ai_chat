import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  Timer? searchDebounce;
  ChatBloc({required ChatRepository myChatRepository})
      : chatRepository = myChatRepository,
        super(const ChatState()) {
    on<ChatEvent>((event, emit) async {
      if (event is LoadChatInfo) {
        await _loadChatInfo(event, emit);
      } else if (event is SendMessageInChat) {
        await _sendMessage(event, emit);
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
        print(state.toString());
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
      final chatId = state.chatId;
      late final ChatModel chat;
      if (chatId != null && chatId.isNotEmpty) {
        chat = state.chatModel;
      } else {
        chat = await chatRepository.createChat(
            userCreatorChat: state.userCreatorChatId);
        emit(state.copyWith(chatModel: chat, chatId: chat.id));
      }

      final Message userMessage = Message.emptyMessage
          .copyWith(message: event.userMessage, createAt: DateTime.now());

      final oldChat = state.chatModel;

      emit(state.copyWith(
          chatModel: state.chatModel
              .copyWith(messages: [...state.chatModel.messages, userMessage]),
          chatPageState: LoadChatPageState.loaded,
          isTyping: true));

      final Message response = await chatRepository.sendMessage(
          chatModel: oldChat, userMessage: userMessage);

      emit(state.copyWith(
          chatModel: state.chatModel
              .copyWith(messages: [...state.chatModel.messages, response]),
          chatPageState: LoadChatPageState.loaded,
          isTyping: false));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}

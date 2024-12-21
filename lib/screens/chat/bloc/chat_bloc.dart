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
      } else if (event is LoadChatHistory) {
        await _loadHistory(event, emit);
      } else if (event is SearchChat) {
        await _searchChat(event, emit);
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
            messages: chatModel.messages,
            userCreatorChatId: event.userId,
            chatId: chatModel.id));
      } else {
        emit(state.copyWith(
          chatId: chatId,
          chatPageState: LoadChatPageState.loaded,
          chatModel: ChatModel.emptyChatModel,
          messages: [],
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
      final chatId = state.chatId;
      late final ChatModel chat;
      if (chatId != null && chatId.isEmpty) {
        chat = state.chatModel;
      } else {
        chat = await chatRepository.createChat(
            userCreatorChat: state.userCreatorChatId);
        emit(state.copyWith(chatModel: chat, chatId: chat.id));
      }

      final Message userMessage = Message.emptyMessage
          .copyWith(message: event.userMessage, createAt: DateTime.now());
      emit(state.copyWith(
          messages: [...state.messages, userMessage],
          chatPageState: LoadChatPageState.loaded,
          isTyping: true));

      final Message response = await chatRepository.sendMessage(
          chatModel: state.chatModel, userMessage: userMessage);

      List<Message>? messages = [...state.messages, response];

      emit(state.copyWith(
          messages: messages,
          chatPageState: LoadChatPageState.loaded,
          isTyping: false));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _loadHistory(LoadChatHistory event, emit) async {
    emit(state.copyWith(loadHistoryState: LoadHistoryState.loading));
    try {
      final history =
          await chatRepository.getHistoryCurrentUser(userId: event.userId!);

      emit(state.copyWith(
          loadHistoryState: LoadHistoryState.loaded, chatHistory: history));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _searchChat(SearchChat event, emit) async {
    if (state.loadHistoryState != LoadHistoryState.loaded) {
      emit(state.copyWith(loadHistoryState: LoadHistoryState.loading));
    }
    try {
      searchDebounce?.cancel();

      final completer = Completer<void>();
      searchDebounce = Timer(const Duration(milliseconds: 300), () async {
        final history = await chatRepository.searchChat(
            userId: state.userCreatorChatId, query: event.query);
        emit(
          state.copyWith(
              chatHistory: history, loadHistoryState: LoadHistoryState.loading),
        );
        completer.complete();
      });
      await completer.future;
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}

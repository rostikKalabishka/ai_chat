import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
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
      if (chatId != null) {
        final ChatModel chatModel =
            await chatRepository.getChat(chatId: chatId);

        emit(state.copyWith(
            chatPageState: LoadChatPageState.loaded, chatModel: chatModel));
      } else {
        emit(state.copyWith(
            chatPageState: LoadChatPageState.loaded,
            chatModel: ChatModel.emptyChatModel));
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
      final Message userMessage =
          Message.emptyMessage.copyWith(message: event.userMessage);
      emit(state.copyWith(
          messages: [...state.messages, userMessage],
          chatPageState: LoadChatPageState.loaded));

      final Message response = await chatRepository.sendMessage(
          chatModel: state.chatModel, userMessage: userMessage);

      emit(state.copyWith(
          messages: [...state.messages, response],
          chatPageState: LoadChatPageState.loaded));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}

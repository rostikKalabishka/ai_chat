part of 'chat_bloc.dart';

enum LoadChatPageState { loading, loaded, unknown }

class ChatState extends Equatable {
  const ChatState({
    this.error = '',
    this.chatId = '',
    this.isTyping = false,
    this.chatPageState = LoadChatPageState.unknown,
    this.chatModel = ChatModel.emptyChatModel,
    this.userCreatorChatId = '',
  });

  final Object error;
  final LoadChatPageState chatPageState;

  final ChatModel chatModel;

  final String? chatId;
  final bool isTyping;
  final String userCreatorChatId;

  @override
  List<Object> get props => [
        error,
        chatPageState,
        chatModel,
        isTyping,
        userCreatorChatId,
        chatId ?? ''
      ];

  ChatState copyWith({
    Object? error,
    LoadChatPageState? chatPageState,
    ChatModel? chatModel,
    String? chatId,
    bool? isTyping,
    String? userCreatorChatId,
  }) {
    return ChatState(
        error: error ?? this.error,
        chatId: chatId ?? this.chatId,
        chatPageState: chatPageState ?? this.chatPageState,
        chatModel: chatModel ?? this.chatModel,
        userCreatorChatId: userCreatorChatId ?? this.userCreatorChatId,
        isTyping: isTyping ?? this.isTyping);
  }
}

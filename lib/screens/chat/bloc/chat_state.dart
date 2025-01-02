part of 'chat_bloc.dart';

enum LoadChatPageState { loading, loaded, unknown }

class ChatState extends Equatable {
  const ChatState({
    this.error = '',
    this.chatId = '',
    this.isTyping = false,
    this.isListening = false,
    this.currentVoiceInput = '',
    this.chatPageState = LoadChatPageState.unknown,
    this.chatModel = ChatModel.emptyChatModel,
    this.userCreatorChatId = '',
  });

  final Object error;
  final LoadChatPageState chatPageState;

  final ChatModel chatModel;
  final bool isListening;
  final String currentVoiceInput;

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
        chatId ?? '',
        isListening,
        currentVoiceInput
      ];

  ChatState copyWith({
    Object? error,
    LoadChatPageState? chatPageState,
    ChatModel? chatModel,
    String? chatId,
    bool? isListening,
    bool? isTyping,
    String? userCreatorChatId,
    String? currentVoiceInput,
  }) {
    return ChatState(
        error: error ?? this.error,
        chatId: chatId ?? this.chatId,
        isListening: isListening ?? this.isListening,
        chatPageState: chatPageState ?? this.chatPageState,
        chatModel: chatModel ?? this.chatModel,
        userCreatorChatId: userCreatorChatId ?? this.userCreatorChatId,
        currentVoiceInput: currentVoiceInput ?? this.currentVoiceInput,
        isTyping: isTyping ?? this.isTyping);
  }
}

part of 'chat_bloc.dart';

enum LoadChatPageState { loading, loaded, unknown }

enum LoadHistoryState { loading, loaded, unknown }

class ChatState extends Equatable {
  const ChatState(
      {this.error = '',
      this.chatId = '',
      this.isTyping = false,
      this.chatPageState = LoadChatPageState.unknown,
      this.loadHistoryState = LoadHistoryState.unknown,
      this.chatModel = ChatModel.emptyChatModel,
      this.userCreatorChatId = '',
      this.chatHistory = const [],
      this.messages = const []});

  final Object error;
  final LoadChatPageState chatPageState;
  final LoadHistoryState loadHistoryState;
  final ChatModel chatModel;
  final List<Message> messages;
  final String chatId;
  final bool isTyping;
  final String userCreatorChatId;
  final List<ChatModel> chatHistory;

  @override
  List<Object> get props => [
        error,
        chatPageState,
        chatModel,
        messages,
        chatId,
        isTyping,
        userCreatorChatId,
        chatHistory,
        loadHistoryState
      ];

  ChatState copyWith(
      {Object? error,
      LoadChatPageState? chatPageState,
      ChatModel? chatModel,
      String? chatId,
      bool? isTyping,
      String? userCreatorChatId,
      List<ChatModel>? chatHistory,
      LoadHistoryState? loadHistoryState,
      List<Message>? messages}) {
    return ChatState(
        error: error ?? this.error,
        chatId: chatId ?? this.chatId,
        chatPageState: chatPageState ?? this.chatPageState,
        chatModel: chatModel ?? this.chatModel,
        loadHistoryState: loadHistoryState ?? this.loadHistoryState,
        messages: messages ?? this.messages,
        userCreatorChatId: userCreatorChatId ?? this.userCreatorChatId,
        chatHistory: chatHistory ?? this.chatHistory,
        isTyping: isTyping ?? this.isTyping);
  }
}

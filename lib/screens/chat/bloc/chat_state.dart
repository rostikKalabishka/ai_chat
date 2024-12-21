part of 'chat_bloc.dart';

enum LoadChatPageState { loading, loaded, unknown }

class ChatState extends Equatable {
  const ChatState(
      {this.error = '',
      this.chatPageState = LoadChatPageState.unknown,
      this.chatModel = ChatModel.emptyChatModel,
      this.messages = const []});

  final Object error;
  final LoadChatPageState chatPageState;
  final ChatModel chatModel;
  final List<Message> messages;

  @override
  List<Object> get props => [error, chatPageState, chatModel, messages];

  ChatState copyWith(
      {Object? error,
      LoadChatPageState? chatPageState,
      ChatModel? chatModel,
      List<Message>? messages}) {
    return ChatState(
        error: error ?? this.error,
        chatPageState: chatPageState ?? this.chatPageState,
        chatModel: chatModel ?? this.chatModel,
        messages: messages ?? this.messages);
  }
}

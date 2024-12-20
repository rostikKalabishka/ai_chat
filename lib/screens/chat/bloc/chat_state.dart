part of 'chat_bloc.dart';

enum LoadChatPageState { load, loaded, unknown }

sealed class ChatState extends Equatable {
  const ChatState(
      {this.error = '',
      this.chatPageState = LoadChatPageState.unknown,
      this.chatModel = ChatModel.emptyChatModel});

  final Object error;
  final LoadChatPageState chatPageState;
  final ChatModel chatModel;

  @override
  List<Object> get props => [error, chatPageState];
}

final class ChatInitial extends ChatState {}

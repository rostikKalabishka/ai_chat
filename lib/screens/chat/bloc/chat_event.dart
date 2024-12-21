// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChatInfo extends ChatEvent {
  final String? chatId;

  const LoadChatInfo({this.chatId});
}

class SendMessageInChat extends ChatEvent {
  const SendMessageInChat(
    this.userMessage,
  );
  final String userMessage;

  @override
  List<Object> get props => super.props..add(userMessage);
}

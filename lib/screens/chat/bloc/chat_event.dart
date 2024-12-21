// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChatInfo extends ChatEvent {
  final String? chatId;
  final String userId;

  const LoadChatInfo({
    this.chatId,
    required this.userId,
  });

  @override
  List<Object> get props => super.props..addAll([userId]);
}

class SendMessageInChat extends ChatEvent {
  const SendMessageInChat(
    this.userMessage,
  );
  final String userMessage;

  @override
  List<Object> get props => super.props..add(userMessage);
}

class LoadChatHistory extends ChatEvent {
  final String? userId;

  const LoadChatHistory({this.userId});
}

class SearchChat extends ChatEvent {
  final String query;

  const SearchChat({required this.query});

  @override
  List<Object> get props => super.props..addAll([query]);
}

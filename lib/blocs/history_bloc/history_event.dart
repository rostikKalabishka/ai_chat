part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadChatHistory extends HistoryEvent {
  final String userId;

  const LoadChatHistory({required this.userId});
}

class SearchChat extends HistoryEvent {
  final String query;
  final String userId;

  const SearchChat({
    required this.query,
    required this.userId,
  });

  @override
  List<Object> get props => super.props..addAll([query, userId]);
}

class ChatHistoryUpdated extends HistoryEvent {
  final List<ChatModel> chatHistory;

  const ChatHistoryUpdated({required this.chatHistory});
}

class DeleteChat extends HistoryEvent {
  final String chatId;

  const DeleteChat({
    required this.chatId,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      chatId,
    ]);
}

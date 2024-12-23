part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadChatHistory extends HistoryEvent {
  final String? userId;

  const LoadChatHistory({this.userId});
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

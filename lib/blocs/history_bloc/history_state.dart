part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<ChatModel> chatHistory;

  const HistoryLoadedState({required this.chatHistory});

  @override
  List<Object> get props => super.props..add(chatHistory);
}

class HistoryLoadingState extends HistoryState {}

class HistoryErrorState extends HistoryState {
  final Object error;

  const HistoryErrorState({required this.error});

  @override
  List<Object> get props => super.props..add(error);
}

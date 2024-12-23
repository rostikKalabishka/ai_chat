import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final ChatRepository chatRepository;
  Timer? searchDebounce;
  HistoryBloc({required ChatRepository myChatRepository})
      : chatRepository = myChatRepository,
        super(HistoryInitial()) {
    on<HistoryEvent>((event, emit) async {
      if (event is LoadChatHistory) {
        await _loadHistory(event, emit);
      } else if (event is SearchChat) {
        await _searchChat(event, emit);
      }
    });
  }

  Future<void> _loadHistory(LoadChatHistory event, emit) async {
    if (state is! HistoryLoadedState) {
      emit(HistoryLoadingState());
    }
    try {
      final history =
          await chatRepository.getHistoryCurrentUser(userId: event.userId!);

      emit(HistoryLoadedState(chatHistory: history));
    } catch (e) {
      log(e.toString());
      emit(HistoryErrorState(error: e));
    }
  }

  Future<void> _searchChat(SearchChat event, emit) async {
    if (state is! HistoryLoadedState) {
      emit(HistoryLoadingState());
    }
    try {
      searchDebounce?.cancel();

      final completer = Completer<void>();
      searchDebounce = Timer(const Duration(milliseconds: 300), () async {
        final history = await chatRepository.searchChat(
            userId: event.userId, query: event.query);

        emit(HistoryLoadedState(chatHistory: history));

        completer.complete();
      });
      await completer.future;
    } catch (e) {
      log(e.toString());
      emit(HistoryErrorState(error: e));
    }
  }
}

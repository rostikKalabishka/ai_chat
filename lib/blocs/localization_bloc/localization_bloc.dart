import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial()) {
    on<LocalizationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

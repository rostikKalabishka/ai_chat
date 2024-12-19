import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserRepository userRepository;
  SettingsBloc({
    required UserRepository myUserRepository,
  })  : userRepository = myUserRepository,
        super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is SettingsSignOutEvent) {
        await _signOut(event, emit);
      }
    });
  }

  Future<void> _signOut(SettingsSignOutEvent event, emit) async {
    emit(SettingsSignOutProcessState());
    try {
      await userRepository.logOut();

      emit(SettingsSignOutSuccessState());
    } catch (e) {
      emit(SettingsFailureState(error: e));
    }
  }
}

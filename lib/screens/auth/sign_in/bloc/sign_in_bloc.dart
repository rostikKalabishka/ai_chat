import 'package:ai_chat/core/errors/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  SignInBloc({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is SingInRequired) {
        await _login(event, emit);
      }
    });
  }

  Future<void> _login(SingInRequired event, emit) async {
    emit(SignInProcessState());
    try {
      await userRepository.login(email: event.email, password: event.password);
      emit(SignInSuccessState());
    } catch (e) {
      print(mapErrorToMessage(error: e));
      emit(SignInFailureState(error: mapErrorToMessage(error: e)));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;
  SignUpBloc({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpRequired) {
        await registration(event, emit);
      }
    });
  }

  Future<void> registration(SignUpRequired event, emit) async {
    emit(SignUpProcessState());
    try {
      UserModel userModel = UserModel.emptyUser
          .copyWith(email: event.email, username: event.userName);
      final newUser = await userRepository.registration(
          password: event.password, userModel: userModel);

      await userRepository.setUserData(newUser);
      emit(SignUpSuccessState());
    } catch (e) {
      emit(SignUpFailureState(error: e));
    }
  }
}

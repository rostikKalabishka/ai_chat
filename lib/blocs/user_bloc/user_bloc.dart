import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUser) {
        await _getUser(event, emit);
      } else if (event is UpdateUserInfo) {
        await _uploadPicture(event, emit);
      }
    });
  }

  Future<void> _getUser(GetUser event, emit) async {
    if (state is! UserInfoLoading) {
      emit(UserInfoLoading());
    }
    try {
      final UserModel userModel = await userRepository.getMyUser(event.userId);
      emit(UserInfoLoaded(userModel: userModel));
    } catch (e) {
      emit(UserInfoError(error: e));
    }
  }

  Future<void> _uploadPicture(UpdateUserInfo event, emit) async {
    if (state is! UserInfoLoading) {
      emit(UserInfoLoading());
    }
    try {
      final file = await userRepository.uploadPicture(
          event.userImage, event.userModel.id);
      emit(
          UserInfoLoaded(userModel: event.userModel.copyWith(userImage: file)));
    } catch (e) {
      emit(UserInfoError(error: e));
    }
  }
}

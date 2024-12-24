import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(const UserState()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUser) {
        await _getUser(event, emit);
      } else if (event is UpdateUserInfo) {
        await _uploadPicture(event, emit);
      }
    });
  }

  Future<void> _getUser(GetUser event, emit) async {
    if (state.userStatus != UserStatus.loaded) {
      emit(state.copyWith(userStatus: UserStatus.loading));
    }
    try {
      final UserModel userModel = await userRepository.getMyUser(event.userId);
      emit(state.copyWith(userModel: userModel, userStatus: UserStatus.loaded));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> _uploadPicture(UpdateUserInfo event, emit) async {
    if (state.userStatus != UserStatus.loaded) {
      emit(state.copyWith(userStatus: UserStatus.loading));
    }
    try {
      final file = await userRepository.uploadPicture(
          event.userImage, event.userModel.id);

      emit(state.copyWith(
          userModel: event.userModel.copyWith(userImage: file),
          userStatus: UserStatus.loaded));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}

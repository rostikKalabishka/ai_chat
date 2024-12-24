part of 'user_bloc.dart';

enum UserStatus {
  loading,
  loaded,
  unknown,
}

class UserState extends Equatable {
  const UserState(
      {this.userModel = UserModel.emptyUser,
      this.error = '',
      this.userStatus = UserStatus.unknown});

  final UserModel userModel;
  final Object error;
  final UserStatus userStatus;

  @override
  List<Object> get props => [userModel, error, userStatus];

  UserState copyWith({
    Object? error,
    UserModel? userModel,
    UserStatus? userStatus,
  }) {
    return UserState(
      error: error ?? this.error,
      userStatus: userStatus ?? this.userStatus,
      userModel: userModel ?? this.userModel,
    );
  }
}

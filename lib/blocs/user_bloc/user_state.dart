part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class UserInfoLoaded extends UserState {
  final UserModel userModel;

  const UserInfoLoaded({required this.userModel});

  @override
  List<Object> get props => super.props..add(userModel);
}

class UserInfoError extends UserState {
  final Object error;

  const UserInfoError({required this.error});

  @override
  List<Object> get props => super.props..add(error);
}

class UserInfoLoading extends UserState {}

// class UserInfoUpdateLoading extends UserState {}

// class UserInfoUpdateSuccess extends UserState {}

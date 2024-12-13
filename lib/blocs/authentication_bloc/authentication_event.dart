part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged([this.user = UserModel.emptyUser]);

  final UserModel? user;
  @override
  List<Object> get props => super.props..add(user ?? UserModel.emptyUser);
}

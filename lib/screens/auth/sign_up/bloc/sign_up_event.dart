part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final String userName;
  final String email;
  final String password;

  const SignUpRequired(
      {required this.userName, required this.email, required this.password});

  @override
  List<Object> get props => super.props..addAll([userName, email, password]);
}

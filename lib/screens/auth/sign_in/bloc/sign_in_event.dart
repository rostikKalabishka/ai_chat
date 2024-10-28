part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SingInRequired extends SignInEvent {
  final String email;
  final String password;

  const SingInRequired({required this.email, required this.password});

  @override
  List<Object> get props => super.props..addAll([email, password]);
}

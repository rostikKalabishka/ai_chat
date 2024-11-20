import 'package:ai_chat/blocs/uthentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:ai_chat/screens/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:ai_chat/screens/settings/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:user_repository/user_repository.dart';

GetIt getIt = GetIt.instance;

void initDi() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());

  getIt.registerLazySingleton<SignInBloc>(
      () => SignInBloc(myUserRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<SignUpBloc>(
      () => SignUpBloc(myUserRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<AuthenticationBloc>(
      () => AuthenticationBloc(myUserRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<SettingsBloc>(
      () => SettingsBloc(myUserRepository: getIt<UserRepository>()));
}

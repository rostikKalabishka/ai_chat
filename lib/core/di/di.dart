import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/blocs/history_bloc/history_bloc.dart';
import 'package:ai_chat/core/utils/helpers/helpers.dart';
import 'package:ai_chat/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:ai_chat/screens/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:ai_chat/screens/chat/bloc/chat_bloc.dart';
import 'package:ai_chat/screens/settings/bloc/settings_bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

GetIt getIt = GetIt.instance;

void initDi(SharedPreferences sharedPreferences) {
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepository());
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<Helpers>(
      () => Helpers(mySharedPref: sharedPreferences));

  getIt.registerLazySingleton<SignInBloc>(
      () => SignInBloc(myUserRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<SignUpBloc>(
      () => SignUpBloc(myUserRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<AuthenticationBloc>(
      () => AuthenticationBloc(myUserRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<SettingsBloc>(
      () => SettingsBloc(myUserRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<ChatBloc>(() => ChatBloc(
        myChatRepository: getIt<ChatRepository>(),
      ));

  getIt.registerLazySingleton<HistoryBloc>(() => HistoryBloc(
        myChatRepository: getIt<ChatRepository>(),
      ));
}

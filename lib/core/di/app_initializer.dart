import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/blocs/history_bloc/history_bloc.dart';
import 'package:ai_chat/blocs/user_bloc/user_bloc.dart';
import 'package:ai_chat/core/di/di.dart';
import 'package:ai_chat/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:ai_chat/screens/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:ai_chat/screens/chat/bloc/chat_bloc.dart';
import 'package:ai_chat/screens/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//test
class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<SignUpBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<SignInBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<SettingsBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<ChatBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<HistoryBloc>(),
        ),
        BlocProvider(
            create: (_) => getIt<UserBloc>()
              ..add(GetUser(
                  userId: context.read<AuthenticationBloc>().state.user!.id)))
      ],
      child: child,
    );
  }
}

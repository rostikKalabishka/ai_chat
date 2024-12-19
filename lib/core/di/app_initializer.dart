import 'package:ai_chat/core/di/di.dart';
import 'package:ai_chat/screens/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:ai_chat/screens/auth/sign_up/bloc/sign_up_bloc.dart';
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
      ],
      child: child,
    );
  }
}

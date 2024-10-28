import 'package:ai_chat/blocs/uthentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/configs/firebase_options.dart';
import 'package:ai_chat/core/di/app_initializer.dart';
import 'package:ai_chat/core/di/di.dart';
import 'package:ai_chat/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:ai_chat/screens/auth/sign_up/view/sign_up.dart';
import 'package:ai_chat/screens/chat/view/chat_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_repository/user_repository.dart';

import 'core/routes/router.dart';
import 'core/ui/theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initDi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _router = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthenticationBloc(myUserRepository: getIt<UserRepository>()),
      child: AppInitializer(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'AI Chat',
          theme: darkTheme,
          routerConfig: _router.config(),
        ),
      ),
    );
  }
}

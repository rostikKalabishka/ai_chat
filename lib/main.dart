import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/blocs/theme_cubit/theme_cubit.dart';
import 'package:ai_chat/configs/firebase_options.dart';
import 'package:ai_chat/core/di/app_initializer.dart';
import 'package:ai_chat/core/di/di.dart';
import 'package:ai_chat/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

import 'core/routes/router.dart';
import 'core/ui/theme/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  initDi(sharedPreferences);
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
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (BuildContext context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'AI Chat',
              theme: state.isDark ? darkTheme : lightTheme,
              routerConfig: _router.config(),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale('de'),
              supportedLocales: S.delegate.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}

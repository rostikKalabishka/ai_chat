import 'package:ai_chat/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:ai_chat/screens/auth/sign_up/view/sign_up.dart';
import 'package:ai_chat/screens/chat/view/chat_screen.dart';
import 'package:ai_chat/screens/loader/view/loader.dart';
import 'package:ai_chat/screens/onboarding/view/onboarding.dart';
import 'package:ai_chat/screens/settings/view/settings_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoaderRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: SignInRoute.page,
          path: '/sign_in',
        ),
        AutoRoute(
          page: SignUpRoute.page,
          path: '/sign_up',
        ),
        AutoRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
        ),
        AutoRoute(
          page: ChatRoute.page,
          path: '/chat',
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: '/chat/settings',
        ),
      ];
}

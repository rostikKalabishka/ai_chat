import 'package:ai_chat/screens/auth/sign_in/view/sign_in_screen.dart';
import 'package:ai_chat/screens/auth/sign_up/view/sign_up.dart';
import 'package:ai_chat/screens/chat/view/chat_screen.dart';
import 'package:ai_chat/screens/loader/view/loader.dart';
import 'package:auto_route/auto_route.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoaderRoute.page,
          path: '/',
          children: [],
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
          page: ChatRoute.page,
          path: '/chat',
        ),
      ];
}

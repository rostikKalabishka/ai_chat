import 'package:ai_chat/blocs/uthentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        navigateTo(context, state);
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }

  void navigateTo(BuildContext context, AuthenticationState state) {
    final navigatorToNextScreen =
        state.status == AuthenticationStatus.authenticated
            ? const ChatRoute()
            : const SignInRoute();

    AutoRouter.of(context)
        .pushAndPopUntil(navigatorToNextScreen, predicate: (router) => false);
  }
}

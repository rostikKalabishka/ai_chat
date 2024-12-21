// import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:ai_chat/core/di/di.dart';
// import 'package:ai_chat/core/routes/router.dart';
// import 'package:ai_chat/core/utils/helpers/helpers.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// @RoutePage()
// class LoaderScreen extends StatefulWidget {
//   const LoaderScreen({super.key});

//   @override
//   State<LoaderScreen> createState() => _LoaderScreenState();
// }

// class _LoaderScreenState extends State<LoaderScreen> {
//   late Helpers helpers;
//   @override
//   void initState() {
//     helpers = Helpers(mySharedPref: getIt<SharedPreferences>());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthenticationBloc, AuthenticationState>(
//       listener: (context, state) {
//         navigateTo(context, state, helpers);
//       },
//       builder: (context, state) {
//         return const Scaffold(
//           body: Center(
//             child: CircularProgressIndicator.adaptive(),
//           ),
//         );
//       },
//     );
//   }

//   void navigateTo(
//       BuildContext context, AuthenticationState state, Helpers helpers) {
//     final navigatorToNextScreen =
//         state.status == AuthenticationStatus.authenticated
//             ? const ChatRoute()
//             : const SignInRoute();

//     // late final navigatorToNextScreen;
//     // if (state.status == AuthenticationStatus.authenticated) {
//     //   navigatorToNextScreen = const ChatRoute();
//     // } else if (state.status != AuthenticationStatus.authenticated &&
//     //     await helpers.showOnboarding() == true) {
//     //   navigatorToNextScreen = const OnboardingRoute();
//     //   await helpers.setBoolForShowOnboarding(showOnboardingBool: false);
//     // } else {
//     //   navigatorToNextScreen = const SignInRoute();
//     // }

//     AutoRouter.of(context)
//         .pushAndPopUntil(navigatorToNextScreen, predicate: (router) => false);
//   }
// }

import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';

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
    if (state.status == AuthenticationStatus.authenticated) {
      AutoRouter.of(context)
          .pushAndPopUntil(ChatRoute(), predicate: (router) => false);
    } else {
      AutoRouter.of(context)
          .pushAndPopUntil(const SignInRoute(), predicate: (router) => false);
    }
  }
}

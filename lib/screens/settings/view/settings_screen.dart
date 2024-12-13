import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/screens/settings/bloc/settings_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (BuildContext context, state) {
        if (state is SettingsSignOutSuccessState) {
          AutoRouter.of(context)
              .pushAndPopUntil(const LoaderRoute(), predicate: (_) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ListTile(
                    title: const Text('Sign out'),
                    onTap: () {
                      context.read<SettingsBloc>().add(SettingsSignOutEvent());
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

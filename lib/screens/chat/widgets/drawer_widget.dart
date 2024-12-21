import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:ai_chat/screens/chat/bloc/chat_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthenticationBloc>().state.user;
    final history = context.read<ChatBloc>().state.chatHistory;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Drawer(
          child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: TextField(
                onChanged: (value) {
                  if (value.isEmpty) {
                    context.read<ChatBloc>().add(const LoadChatHistory());
                  } else {
                    context.read<ChatBloc>().add(SearchChat(query: value));
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'History'),
              ),
            ),
            const Divider(),
            Flexible(
              child: RefreshIndicator.adaptive(
                onRefresh: () async {
                  context.read<ChatBloc>().add(const LoadChatHistory());
                },
                child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(history[index].chatName),
                        onTap: () {
                          AutoRouter.of(context)
                              .push(ChatRoute(chatId: history[index].id));
                        },
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(const SettingsRoute());
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      child: ClipOval(
                        child: currentUser != null &&
                                currentUser.userImage.isNotEmpty
                            ? Image.network(currentUser.userImage)
                            : Image.asset(
                                AssetsManager.userImage,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(currentUser != null ? currentUser.username : '')
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

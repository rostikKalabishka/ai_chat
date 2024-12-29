import 'package:ai_chat/blocs/history_bloc/history_bloc.dart';
import 'package:ai_chat/blocs/user_bloc/user_bloc.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/ui.dart';
import 'package:ai_chat/generated/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final historyBloc = context.read<HistoryBloc>();
    historyBloc.add(
        LoadChatHistory(userId: context.read<UserBloc>().state.userModel.id));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserBloc>().state.userModel;

    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        if (state is HistoryLoadedState) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 40, left: 10, right: 10),
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          final historyBloc = context.read<HistoryBloc>();
                          if (value.isEmpty) {
                            historyBloc.add(
                              LoadChatHistory(userId: currentUser.id),
                            );
                          } else {
                            historyBloc.add(
                              SearchChat(
                                  query: value.trim(), userId: currentUser.id),
                            );
                          }
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          prefixIcon: const Icon(Icons.search),
                          hintText: S.of(context).search,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2),
                    Flexible(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () async {
                          context.read<HistoryBloc>().add(
                                LoadChatHistory(userId: currentUser.id),
                              );
                        },
                        child: ListView.builder(
                          itemCount: state.chatHistory.length,
                          itemBuilder: (context, index) {
                            final chat = state.chatHistory[index];
                            return Slidable(
                              key: ValueKey(chat.id),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 2,
                                    onPressed: (context) {
                                      context
                                          .read<HistoryBloc>()
                                          .add(DeleteChat(chatId: chat.id));
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: S.of(context).delete,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: TextWidget(
                                  isTextOverflow: true,
                                  label: chat.chatName,
                                  color: theme.textTheme.titleSmall?.color,
                                  fontWeight:
                                      theme.textTheme.titleSmall?.fontWeight,
                                ),
                                onTap: () {
                                  AutoRouter.of(context)
                                      .push(ChatRoute(chatId: chat.id));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Divider(thickness: 2),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          AutoRouter.of(context).push(const SettingsRoute());
                        },
                        child: Row(
                          children: [
                            MyCircleAvatar(
                              userImage: currentUser.userImage,
                              radius: 18,
                            ),
                            const SizedBox(width: 10),
                            TextWidget(
                              isTextOverflow: true,
                              label: currentUser.username,
                              color: theme.textTheme.titleSmall?.color,
                              fontWeight:
                                  theme.textTheme.titleSmall?.fontWeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

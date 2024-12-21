import 'dart:developer';

import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:ai_chat/screens/chat/bloc/chat_bloc.dart';
import 'package:chat_repository/chat_repository.dart';

import 'package:ai_chat/screens/chat/widgets/chat_widget.dart';
import 'package:ai_chat/screens/chat/widgets/drawer_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.chatId});
  final String? chatId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _textFieldController;
  late ScrollController _scrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    _scrollController = ScrollController();
    focusNode = FocusNode();
    final String userId = context.read<AuthenticationBloc>().state.user!.id;
    log(widget.chatId.toString());
    context
        .read<ChatBloc>()
        .add(LoadChatInfo(chatId: widget.chatId, userId: userId));

    context.read<ChatBloc>().add(LoadChatHistory(userId: userId));

    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(const SettingsRoute());
                  },
                  child: CircleAvatar(
                    radius: 18,
                    child: ClipOval(
                      child: Image.asset(
                        AssetsManager.userImage,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<ChatBloc>().add(LoadChatInfo(
                  chatId: state.chatId, userId: state.userCreatorChatId));
            },
            child: state.chatPageState == LoadChatPageState.loaded
                ? Center(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                final List<Message> messagesInChat =
                                    state.messages;
                                return ChatWidget(
                                  isUser: messagesInChat[index].isUser,
                                  message: messagesInChat[index].message,
                                );
                              },
                              itemCount: state.messages.length,
                            ),
                          ),
                          if (state.isTyping) ...[
                            const SpinKitThreeBounce(
                              color: Color.fromARGB(255, 106, 153, 107),
                              size: 18,
                            ),
                          ],
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            color: theme.cardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      controller: _textFieldController,
                                      onSubmitted: (value) {},
                                      decoration:
                                          const InputDecoration.collapsed(
                                        hintText: 'How can i help you',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          final newMessage =
                                              _textFieldController.text.trim();
                                          _textFieldController.clear();

                                          if (newMessage.isNotEmpty) {
                                            context.read<ChatBloc>().add(
                                                SendMessageInChat(newMessage));
                                            _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeOut,
                                            );
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
          ),
        );
      },
    );
  }
}

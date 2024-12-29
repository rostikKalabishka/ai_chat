import 'dart:ui';

import 'package:ai_chat/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ai_chat/blocs/history_bloc/history_bloc.dart';
import 'package:ai_chat/blocs/user_bloc/user_bloc.dart';
import 'package:ai_chat/core/routes/router.dart';

import 'package:ai_chat/core/ui/ui.dart';
import 'package:ai_chat/generated/l10n.dart';
import 'package:ai_chat/screens/chat/bloc/chat_bloc.dart';
import 'package:chat_repository/chat_repository.dart';

import 'package:ai_chat/screens/chat/widgets/chat_widget.dart';
import 'package:ai_chat/screens/chat/widgets/drawer_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  final SpeechToText _speechToText = SpeechToText();

  bool _isListening = false;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    _scrollController = ScrollController();
    focusNode = FocusNode();

    _init();

    super.initState();
  }

  void _init() {
    final String userId = context.read<AuthenticationBloc>().state.user!.id;

    context
        .read<ChatBloc>()
        .add(LoadChatInfo(chatId: widget.chatId, userId: userId));

    context.read<HistoryBloc>().add(LoadChatHistory(userId: userId));
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
        return GestureDetector(
          onTap: () {
            focusNode.unfocus();
          },
          child: Scaffold(
            drawer: const DrawerWidget(),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: state.chatModel.messages.isNotEmpty
                      ? () {
                          AutoRouter.of(context).push(ChatRoute(chatId: null));
                        }
                      : null,
                  icon: Icon(
                    Icons.add_circle_outlined,
                    color: state.chatModel.messages.isNotEmpty
                        ? null
                        : Colors.grey[800],
                    size: 32,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () async {
                          await _navigateToSettingsPage(state, context);
                        },
                        child: MyCircleAvatar(
                          userImage: state.userModel.userImage,
                          radius: 18,
                        ),
                      );
                    },
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
                                      state.chatModel.messages;
                                  return ChatWidget(
                                    isUser: messagesInChat[index].isUser,
                                    message: messagesInChat[index].message,
                                  );
                                },
                                itemCount: state.chatModel.messages.length,
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
                                        focusNode: focusNode,
                                        controller: _textFieldController,
                                        onSubmitted: (value) {
                                          _sendMessage(context);
                                        },
                                        decoration: InputDecoration.collapsed(
                                          hintText: S
                                              .of(context)
                                              .howCanIHelpYouHintText,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: _toggleListening,
                                        icon: Icon(
                                          _isListening == false
                                              ? Icons.mic
                                              : Icons.mic_off,
                                          color:
                                              _isListening ? Colors.red : null,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          _sendMessage(context);
                                        },
                                        icon: const Icon(
                                          Icons.send,
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
          ),
        );
      },
    );
  }

  Future<void> _navigateToSettingsPage(
      UserState state, BuildContext context) async {
    if (state.userStatus == UserStatus.loaded) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();

        await Future.delayed(const Duration(milliseconds: 300)).then((val) {
          if (!mounted) return;

          AutoRouter.of(context).push(
            const SettingsRoute(),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User information is not available')),
      );
    }
  }

//fix
  Future<void> _toggleListening() async {
    final deviceLocale = PlatformDispatcher.instance.locale;
    // if (!_isListening) {
    //   bool available = await _speechToText.initialize();
    //   if (available) {
    //     setState(() {
    //       _isListening = true;
    //     });
    //     _speechToText.listen(
    //       localeId: deviceLocale.languageCode,
    //       onResult: (result) {
    //         setState(() {
    //           _textFieldController.text = '${result.recognizedWords} ';
    //         });
    //       },
    //     );
    //   }
    // } else {
    //   setState(() => _isListening = false);

    //   _speechToText.stop();
    // }
  }

  void _sendMessage(BuildContext context) {
    final newMessage = _textFieldController.text.trim();

    if (newMessage.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessageInChat(newMessage));

      _textFieldController.clear();

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

      // Оновлюємо стан після очищення текстового поля
      // setState(() {
      //   if (_isListening) {
      //     _speechToText.stop();
      //     _isListening = false;
      //   }
      // });
    }
  }
}

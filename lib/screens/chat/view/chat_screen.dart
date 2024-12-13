import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';

import 'package:ai_chat/screens/chat/widgets/chat_widget.dart';
import 'package:ai_chat/screens/chat/widgets/drawer_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController _textFieldController;
  late ScrollController _scrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    _scrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final chatMessages = [
    {'message': 'Hello who are you', 'chatIndex': 0},
    {'message': 'Hello, i am ChatGPT', 'chatIndex': 1},
    {'message': 'What is flutter?', 'chatIndex': 0},
    {
      'message': 'Flutter is open-source mobile application dev framework',
      'chatIndex': 1
    },
    {'message': 'Hello who are you', 'chatIndex': 0},
    {'message': 'Hello, i am ChatGPT', 'chatIndex': 1},
    {'message': 'What is flutter?', 'chatIndex': 0},
    {
      'message': 'Flutter is open-source mobile application dev framework',
      'chatIndex': 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      chatIndex: int.parse(
                          chatMessages[index]['chatIndex'].toString()),
                      message: chatMessages[index]['message'].toString(),
                    );
                  },
                  itemCount: chatMessages.length,
                  // controller: _scrollController,
                ),
              ),
              if (_isTyping) ...[
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
                          style: const TextStyle(color: Colors.white),
                          controller: _textFieldController,
                          onSubmitted: (value) {},
                          decoration: const InputDecoration.collapsed(
                            hintText: 'How can i help you',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              final newMessage =
                                  _textFieldController.text.trim();
                              if (newMessage.isNotEmpty) {
                                setState(() {
                                  chatMessages.add(
                                      {'message': newMessage, 'chatIndex': 0});
                                  _textFieldController.clear();
                                });

                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
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
      ),
    );
  }
}

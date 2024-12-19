import 'dart:developer';

import 'package:ai_chat/core/constants/api_const.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
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
  late final GenerativeModel _model;
  List<Message> messagesInChat = [];

  @override
  void initState() {
    _textFieldController = TextEditingController();
    _scrollController = ScrollController();
    focusNode = FocusNode();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: API_KEY,
    );
    super.initState();
  }

  Future<void> _sendMessage() async {
    try {
      final userMessage = _textFieldController.text;
      setState(() {
        messagesInChat
            .add(Message(isUser: 'USER_MESSAGE', message: userMessage));
      });
      _textFieldController.clear();

      final prompt =
          TextPart(messagesInChat.map((e) => e.toJson()).toList().join('\n'));

      print(prompt.text);
      final response = await _model.generateContent([
        Content.multi([prompt])
      ]);
      log(response.text.toString());

      setState(() {
        messagesInChat.add(
            Message(isUser: "BOT_MESSAGE", message: response.text ?? "aboba"));
      });
    } catch (e) {
      log(e.toString());
    }
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
                      isUser: messagesInChat[index].isUser,
                      message: messagesInChat[index].message,
                    );
                  },
                  itemCount: messagesInChat.length,
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
                          onPressed: () async {
                            await _sendMessage();
                            setState(() {
                              final newMessage =
                                  _textFieldController.text.trim();
                              if (newMessage.isNotEmpty) {
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

class Message {
  final String isUser;
  final String message;

  Message({required this.isUser, required this.message});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isUser': isUser,
        'message': message,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        isUser: json['isUser'],
        message: json['message'],
      );
}

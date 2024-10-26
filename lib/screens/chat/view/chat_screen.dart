import 'package:ai_chat/main.dart';
import 'package:ai_chat/screens/chat/widgets/chat_widget.dart';
import 'package:flutter/material.dart';

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
    TextEditingController _textFieldController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:ai_chat/core/ui/ui.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.message,
    required this.isUser,
  });

  final String message;
  final String isUser;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Material(
          color: isUser == "USER_MESSAGE"
              ? theme.scaffoldBackgroundColor
              : theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  isUser == "USER_MESSAGE"
                      ? AssetsManager.userImage
                      : AssetsManager.chatLogoImage,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: isUser == "USER_MESSAGE"
                      ? TextWidget(
                          label: message,
                        )
                      : DefaultTextStyle(
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: true,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(message.trim())
                              ]),
                        ),
                ),
                isUser == 0
                    ? const SizedBox.shrink()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

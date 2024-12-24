import 'package:ai_chat/blocs/user_bloc/user_bloc.dart';
import 'package:ai_chat/core/ui/assets_manager/assets_manager.dart';
import 'package:ai_chat/core/ui/ui.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.message,
    required this.isUser,
  });

  final String message;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserBloc>().state.userModel;
    final theme = Theme.of(context);
    return Column(
      children: [
        Material(
          color: isUser ? theme.scaffoldBackgroundColor : theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isUser
                    ? MyCircleAvatar(
                        userImage: currentUser.userImage,
                        radius: 15,
                      )
                    : Image.asset(
                        AssetsManager.chatLogoImage,
                        width: 30,
                        height: 30,
                      ),
                const SizedBox(width: 10),
                Expanded(
                  child: isUser
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
                isUser
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

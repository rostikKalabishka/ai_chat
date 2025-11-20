import 'package:ai_chat/core/utils/helpers/markdown_text_parser.dart';
import 'package:flutter/material.dart';

class TyperWithBoldText extends StatefulWidget {
  final String message;
  final TextStyle? textStyle;
  final Duration speed;
  final bool shouldAnimate;

  const TyperWithBoldText({
    super.key,
    required this.message,
    this.textStyle,
    this.speed = const Duration(milliseconds: 40),
    this.shouldAnimate = true,
  });

  @override
  State<TyperWithBoldText> createState() => _TyperWithBoldTextState();
}

class _TyperWithBoldTextState extends State<TyperWithBoldText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<InlineSpan> _characters;

  @override
  void initState() {
    super.initState();
    _characters = parseTyperText(widget.message);

    if (widget.shouldAnimate) {
      _controller = AnimationController(
        duration: widget.speed * _characters.length,
        vsync: this,
      )..forward();
    } else {
      _controller = AnimationController(
        duration: Duration.zero,
        vsync: this,
      )..value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final count = (_characters.length * _controller.value).floor();
        return Text.rich(
          TextSpan(
            style: widget.textStyle,
            children: _characters.sublist(0, count),
          ),
        );
      },
    );
  }
}

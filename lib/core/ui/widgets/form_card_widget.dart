import 'package:ai_chat/core/ui/theme/color_constants.dart';
import 'package:flutter/material.dart';

class FormCardWidget extends StatelessWidget {
  const FormCardWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConstants.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

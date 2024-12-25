import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.label,
      this.fontSize = 18,
      this.color,
      this.fontWeight,
      this.isTextOverflow})
      : super(key: key);

  final String label;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final bool? isTextOverflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: TextStyle(
          overflow: isTextOverflow == true ? TextOverflow.ellipsis : null,
          color: color ?? theme.textTheme.bodyLarge?.color,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }
}

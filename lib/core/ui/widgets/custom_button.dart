import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.child,
      this.padding,
      this.margin,
      required this.onPressed,
      this.height,
      this.width});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

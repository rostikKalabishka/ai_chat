import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.obscureText,
    required this.hintText,
  });
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary)),
      ),
    );
  }
}

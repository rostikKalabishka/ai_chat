import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.obscureText,
    required this.hintText,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  final bool? obscureText;
  final IconButton? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      validator: validator,
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary)),
      ),
    );
  }
}

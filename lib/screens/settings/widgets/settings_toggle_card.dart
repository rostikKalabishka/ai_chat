import 'package:ai_chat/core/ui/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsToggleCard extends StatelessWidget {
  const SettingsToggleCard({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      child: BaseContainer(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
              ),
            ),
            if (theme.isAndroid)
              Switch(
                value: value,
                onChanged: onChanged,
              )
            else
              CupertinoSwitch(
                value: value,
                onChanged: onChanged,
              )
          ],
        ),
      ),
    );
  }
}

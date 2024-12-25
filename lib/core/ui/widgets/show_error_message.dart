import 'package:ai_chat/core/ui/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showError(BuildContext context, String errorMessage) {
  final theme = Theme.of(context);
  if (theme.isAndroid) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

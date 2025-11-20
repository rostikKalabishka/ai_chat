import 'package:flutter/material.dart';

List<InlineSpan> parseTyperText(String input) {
  final spans = <InlineSpan>[];
  final regex = RegExp(r'\*\*(.+?)\*\*');
  int currentIndex = 0;

  for (final match in regex.allMatches(input)) {
    if (match.start > currentIndex) {
      final normalText = input.substring(currentIndex, match.start);
      spans.addAll(_charSpans(normalText));
    }

    final boldText = match.group(1)!;
    spans.addAll(_charSpans(boldText, isBold: true));
    currentIndex = match.end;
  }

  if (currentIndex < input.length) {
    final remaining = input.substring(currentIndex);
    spans.addAll(_charSpans(remaining));
  }

  return spans;
}

List<InlineSpan> _charSpans(String text, {bool isBold = false}) {
  return text.split('').map((char) {
    return TextSpan(
      text: char,
      style:
          TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }).toList();
}

final Set<String> seenMessages = {};

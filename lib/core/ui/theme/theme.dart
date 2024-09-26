import 'package:ai_chat/core/ui/theme/color_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: ColorConstants.secondaryColor,
  textTheme: _textTheme,
  appBarTheme: _appBarTheme,
  scaffoldBackgroundColor: ColorConstants.backgroundColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorConstants.secondaryColor,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: ColorConstants.secondaryColor,
  textTheme: _textTheme,
  scaffoldBackgroundColor: const Color(0xFFEFF1F3),
  dividerTheme: DividerThemeData(
    color: Colors.grey.withOpacity(0.1),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorConstants.secondaryColor,
    brightness: Brightness.light,
  ),
);

const _textTheme = TextTheme(
  titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: ColorConstants.textColor),
  headlineLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  ),
);

const _appBarTheme = AppBarTheme(
  surfaceTintColor: Colors.transparent,
);

extension ThemePlatformExtension on ThemeData {
  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}

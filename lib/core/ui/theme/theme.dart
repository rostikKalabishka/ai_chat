import 'package:ai_chat/core/ui/theme/color_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  cardColor: ColorConstants.cardColor,
  dividerColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[400]),
      labelStyle: const TextStyle(color: ColorConstants.textColor)),
  iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(ColorConstants.chatIconButton))),
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
  cardColor: ColorConstants.cardColorLightTheme,
  dividerColor: Colors.black,
  inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black54),
      labelStyle: TextStyle(color: ColorConstants.textColorLightTheme)),
  iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
          iconColor:
              WidgetStatePropertyAll(ColorConstants.chatIconButtonLightTheme))),
  useMaterial3: true,
  primaryColor: ColorConstants.secondaryColor,
  textTheme: _textTheme.copyWith(
      titleMedium: const TextStyle(color: ColorConstants.textColorLightTheme),
      titleSmall: const TextStyle(color: ColorConstants.textColorLightTheme)),
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
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColorConstants.textColor),
  titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
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
  bool get isCupertino => [TargetPlatform.iOS, TargetPlatform.macOS]
      .contains(defaultTargetPlatform);
  Color get cupertinoAlertColor => const Color(0xFFF82B10);
  Color get cupertinoActionColor => const Color(0xFF3478F7);
}

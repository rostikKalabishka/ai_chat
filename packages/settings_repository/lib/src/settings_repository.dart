import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences preferences;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';
  static const _languagePrefsKey = 'languagePrefs';

  SettingsRepository({required this.preferences});

  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? true;
  }

  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }

  Locale getLocale() {
    final savedLanguageCode = preferences.getString(_languagePrefsKey);
    if (savedLanguageCode != null && savedLanguageCode.isNotEmpty) {
      return Locale(savedLanguageCode);
    }

    final deviceLocale = PlatformDispatcher.instance.locale;
    return deviceLocale;
  }

  Future<void> setLocale(Locale locale) async {
    await preferences.setString(
        _languagePrefsKey, locale.languageCode); // зберігаємо лише languageCode
  }
}

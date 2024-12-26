import 'dart:ui';

import 'package:settings_repository/src/abstract_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements AbstractSettingsRepository {
  final SharedPreferences preferences;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';
  static const _languagePrefsKey = 'languagePrefs';

  SettingsRepository({required this.preferences});
  @override
  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }

  @override
  Locale getLocale() {
    final languageCode = preferences.getString(_languagePrefsKey);
    if (languageCode != null) {
      return Locale(languageCode);
    }

    return const Locale('en');
  }

  @override
  Future<void> setLocale(Locale locale) async {
    await preferences.setString(_languagePrefsKey, locale.languageCode);
  }
}

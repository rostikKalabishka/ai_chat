import 'package:flutter/material.dart';

abstract interface class AbstractSettingsRepository {
  bool isDarkThemeSelected();
  Future<void> setDarkThemeSelected(bool selected);
  Future<void> setLocale(Locale locale);
  Locale getLocale();
}

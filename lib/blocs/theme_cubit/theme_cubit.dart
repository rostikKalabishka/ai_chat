import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:settings_repository/settings_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SettingsRepository _settingsRepository;
  ThemeCubit({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(const ThemeState(Brightness.light)) {
    _heckSelectedTheme();
  }

  Future<void> setThemeBrightness(Brightness brightness) async {
    try {
      emit(ThemeState(brightness));
      await _settingsRepository
          .setDarkThemeSelected(brightness == Brightness.dark);
    } catch (e) {
      log(e.toString());
    }
  }

  void _heckSelectedTheme() {
    try {
      final brightness = _settingsRepository.isDarkThemeSelected()
          ? Brightness.dark
          : Brightness.light;
      emit(ThemeState(brightness));
    } catch (e) {
      log(e.toString());
    }
  }
}

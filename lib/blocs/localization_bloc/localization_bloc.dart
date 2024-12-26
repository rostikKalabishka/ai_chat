import 'dart:ui';

import 'package:ai_chat/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:settings_repository/settings_repository.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SettingsRepository _settingsRepository;

  LocalizationBloc({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(LocalizationState(
          _determineInitialLocale(settingsRepository),
        )) {
    on<ChangeLocaleEvent>(_onChangeLocale);
  }

  Future<void> _onChangeLocale(
    ChangeLocaleEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    await _settingsRepository.setLocale(event.locale);

    emit(LocalizationState(event.locale));
  }

  static Locale _determineInitialLocale(SettingsRepository settingsRepository) {
    final deviceLocale = PlatformDispatcher.instance.locale;

    final supportedLocales = S.delegate.supportedLocales;

    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode) {
        return supportedLocale;
      }
    }

    final savedLocale = settingsRepository.getLocale();

    return savedLocale;
  }
}

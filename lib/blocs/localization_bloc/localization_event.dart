part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeLocaleEvent extends LocalizationEvent {
  const ChangeLocaleEvent(this.locale);
  final Locale locale;

  @override
  List<Object> get props => [locale];
}

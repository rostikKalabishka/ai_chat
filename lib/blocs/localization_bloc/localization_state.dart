part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  const LocalizationState(this.locale);
  final Locale locale;

  @override
  List<Object> get props => [locale];
}

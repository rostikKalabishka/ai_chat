part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

class SettingsFailureState extends SettingsState {
  final Object error;

  const SettingsFailureState({required this.error});

  @override
  List<Object> get props => super.props..add(error);
}

class SettingsSignOutProcessState extends SettingsState {}

class SettingsSignOutSuccessState extends SettingsState {}

class SettingsSuccessState extends SettingsState {}

class SettingsProcessState extends SettingsState {}

import 'package:ai_chat/blocs/localization_bloc/localization_bloc.dart';
import 'package:ai_chat/core/ui/ui.dart';
import 'package:ai_chat/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsDropDownCard extends StatelessWidget {
  const SettingsDropDownCard({
    super.key,
    required this.title,
    required this.selectedLocale,
  });

  final String title;
  final Locale selectedLocale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final supportedLocales = S.delegate.supportedLocales;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      child: BaseContainer(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
              ),
            ),
            DropdownButton<Locale>(
              value: selectedLocale,
              underline: const SizedBox.shrink(),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  context
                      .read<LocalizationBloc>()
                      .add(ChangeLocaleEvent(newLocale));
                }
              },
              items: supportedLocales
                  .map<DropdownMenuItem<Locale>>((Locale locale) {
                return DropdownMenuItem<Locale>(
                  value: locale,
                  child: Text(locale.languageCode == "uk"
                      ? "UA"
                      : locale.languageCode.toUpperCase()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
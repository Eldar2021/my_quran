import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class UnauthenticatedLanguageSettings extends StatelessWidget {
  const UnauthenticatedLanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.auth != null) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.selectLanguage,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            LanguageDropdownButtonFormField<Locale>(
              value: state.currentLocale,
              items: AppLocalizationHelper.locales,
              onChanged: (v) => _updateLanguage(v, context),
              itemBuilder: (v) {
                final name = AppLocalizationHelper.getName(v?.toLanguageTag());
                return DropdownMenuItem(
                  value: v,
                  child: Text(name),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _updateLanguage(Locale? locale, BuildContext context) {
    final localeCode = locale?.languageCode ?? 'en';
    context.read<AuthCubit>().updateLocale(localeCode);
  }
}

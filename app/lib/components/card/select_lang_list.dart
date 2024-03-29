import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class SelectLangFromListViewBuilder extends StatelessWidget {
  const SelectLangFromListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      itemCount: AppLocalizationHelper.locales.length,
      itemBuilder: (BuildContext context, int index) {
        final locale = AppLocalizationHelper.locales[index];
        final langName = AppLocalizationHelper.getName(locale.toLanguageTag());
        return Card(
          child: ListTile(
            key: Key(MqKeys.languageCode(locale.languageCode)),
            title: Text(langName, locale: locale),
            onTap: () => context.read<AppCubit>().changeLang(locale.languageCode),
            trailing: appCubit.state.currentLocale == locale
                ? CircleAvatar(
                    radius: 15,
                    backgroundColor: colorScheme.background,
                    child: Icon(Icons.check, color: colorScheme.primary),
                  )
                : null,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class SelectLangFromListViewBuilder extends StatelessWidget {
  const SelectLangFromListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
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
            onTap: () async {
              context.loaderOverlay.show();
              await context.read<AuthCubit>().saveLocale(locale.languageCode);
              if (context.mounted) context.loaderOverlay.hide();
            },
            trailing: authCubit.state.currentLocale == locale
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

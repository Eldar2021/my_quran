import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';

class SelectLangFromListViewBuilder extends StatelessWidget {
  const SelectLangFromListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      itemCount: AppConst.locales.length,
      itemBuilder: (BuildContext context, int index) {
        final locale = AppConst.locales[index];
        final langName = AppConst.getName(locale.toLanguageTag());
        return Card(
          child: ListTile(
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

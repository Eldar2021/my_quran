import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/theme/custom/color/custom_color.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.lang)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: appCubit.localService.locales.length,
              itemBuilder: (BuildContext context, int index) {
                final locale = context.read<AppCubit>().localService.locales[index];
                final langName = context.read<AppCubit>().localService.getName(locale.toLanguageTag());
                return Card(
                  color: appCubit.state.currentLocale == locale ? Colors.green : null,
                  child: ListTile(
                    title: Text(langName, locale: locale),
                    onTap: () async => context.read<AppCubit>().changeLang(index),
                  ),
                );
              },
            ),
            Card(
              color: appCubit.state.theme.brightness == Brightness.dark ? Colors.green : null,
              child: ListTile(
                title: const Text('dark'),
                onTap: () async => context.read<AppCubit>().changeMode(isDark: true),
              ),
            ),
            Card(
              color: appCubit.state.theme.brightness == Brightness.light ? Colors.green : null,
              child: ListTile(
                title: const Text('light'),
                onTap: () async => context.read<AppCubit>().changeMode(isDark: false),
              ),
            ),
            Wrap(
              children: targetColors.entries
                  .map(
                    (e) => SizedBox(
                      width: 20,
                      height: 20,
                      child: InkWell(
                        onTap: () async => context.read<AppCubit>().changeColor(e.key, e.value),
                        child: Card(color: e.value),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

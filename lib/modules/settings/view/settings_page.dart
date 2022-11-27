import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/modules/modules.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsCubit>();
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.lang),
      ),
      body: ListView.builder(
        itemCount: settings.locales.length,
        itemBuilder: (BuildContext context, int index) {
          final locale = context.read<SettingsCubit>().locales[index];
          return Card(
            color: settings.state.currentLocale == locale ? Colors.green : null,
            child: ListTile(
              title: Text(locale.toLanguageTag()),
              onTap: () => context.read<SettingsCubit>().changeLang(index),
            ),
          );
        },
      ),
    );
  }
}

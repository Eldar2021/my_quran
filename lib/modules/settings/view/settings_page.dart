import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/app.dart';
import 'package:hatim/l10n/l10.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.lang),
      ),
      body: ListView.builder(
        itemCount: appCubit.service.locales.length,
        itemBuilder: (BuildContext context, int index) {
          final locale = context.read<AppCubit>().service.locales[index];
          final langName = context.read<AppCubit>().service.getName(locale.toLanguageTag());
          return Card(
            color: appCubit.state.currentLocale == locale ? Colors.green : null,
            child: ListTile(
              title: Text(langName, locale: locale),
              onTap: () => context.read<AppCubit>().changeLang(index),
            ),
          );
        },
      ),
    );
  }
}

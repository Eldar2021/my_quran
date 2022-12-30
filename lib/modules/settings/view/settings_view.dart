import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/l10n/l10.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authCubit = context.watch<AuthCubit>();
    final appCubit = context.watch<AppCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.lang)),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Gender'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(authCubit.state.user?.gender.name ?? ''),
                const SizedBox(width: 17),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, AppRouter.genderSettings),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(appCubit.state.currentLocale.toLanguageTag()),
                const SizedBox(width: 17),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            onTap: () => Navigator.pushNamed(context, AppRouter.langSettings),
          ),
          ListTile(
            title: const Text('Theme'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, AppRouter.themeSettings),
          ),
          ListTile(
            title: const Text('About Us'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, AppRouter.aboutUs),
          ),
          ListTile(
            title: const Text('Feedback'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.feedbackSnackbarTitle)),
              );
            },
          ),
          ListTile(
            title: const Text('Developers'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, AppRouter.developers),
          ),
        ],
      ),
    );
  }
}

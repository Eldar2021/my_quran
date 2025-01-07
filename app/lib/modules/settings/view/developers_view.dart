import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class DevelopersView extends StatelessWidget {
  const DevelopersView({super.key});

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: Text(context.l10n.profileForDevelopers),
        key: const Key(MqKeys.settingsDevelopersPage),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Text(
              context.l10n.profileDevsDesc,
              style: prTextTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ContactGithubButton(
              // labelText: context.l10n.gi,
              onPressed: () {
                AppLaunch.launchURL(apiConst.urlGitHub);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

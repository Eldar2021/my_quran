import 'package:flutter/material.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class DevelopersView extends StatelessWidget {
  const DevelopersView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsDevelopersPage),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          children: [
            Text(
              context.l10n.profileForDevelopers,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.profileDevsDesc,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            CustomButtonWithIcon(
              onPressed: () => AppLaunch.launchURL(apiConst.urlGitHub),
              text: 'GitHub',
              icon: Assets.icons.github.svg(
                height: 35,
                colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

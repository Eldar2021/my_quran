import 'package:flutter/material.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/config/config.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsPrivacyPolicyPage),
        title: Text(context.l10n.privacyPolicy),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          children: [
            Text(
              context.l10n.privacyPolicy,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.privacyPolicyDesc,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            CustomButtonWithIcon(
              onPressed: () => AppLaunch.launchURL(apiConst.urlPrivacyPolicy),
              text: context.l10n.privacyPolicy,
              icon: Icon(
                Icons.privacy_tip_outlined,
                weight: 35,
                color: colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

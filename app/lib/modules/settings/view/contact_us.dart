import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return ScaffoldWithBgImage(
      appBar: AppBar(
        key: const Key(MqKeys.settingsContactUsPage),
        title: Text(context.l10n.contactUs),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.assalamuAlaikum,
              style: prTextTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.feedbackMessage,
              style: prTextTheme.bodyMedium,
            ),
            const SizedBox(height: 15),
            Text(
              context.l10n.withRespect,
              style: prTextTheme.bodyMedium,
            ),
            const Spacer(),
            const SizedBox(height: 16),
            ContactWhatsappButton(
              labelText: context.l10n.chatOnWhatsApp,
              onPressed: () {
                AppLaunch.sendWhatsApp(
                  '996990039301',
                  snackBarText: context.l10n.errorOccurred,
                  context: context,
                );
              },
            ),
            const SizedBox(height: 20),
            ContactTelegramButton(
              labelText: context.l10n.connectOnTelegram,
              onPressed: () {
                AppLaunch.sendTelegram(
                  'ak_bulak',
                  snackBarText: context.l10n.errorOccurred,
                  context: context,
                );
              },
            ),
            const SizedBox(height: 20),
            ContactEmailButton(
              labelText: context.l10n.contactViaEmail,
              onPressed: () {
                AppLaunch.sendEmail(
                  'eldiiaralmazbekov@gmail.com',
                  snackBarText: context.l10n.errorOccurred,
                  context: context,
                );
              },
            ),
            SizedBox(height: AppSpacing.bottomSpace),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsContactUsPage),
        backgroundColor: context.colors.primaryContainer,
        title: Text(context.l10n.contactUs),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ContactUsCard(),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SocialIconButton(
                iconData: FontAwesomeIcons.whatsapp,
                onPressed: () async => AppLaunch.sendWhatsApp(
                  '996990039301',
                  snackBarText: context.l10n.feedBackSms,
                  context: context,
                ),
              ),
              SocialIconButton(
                iconData: FontAwesomeIcons.telegram,
                onPressed: () async => AppLaunch.sendTelegram(
                  'ak_bulak',
                  snackBarText: context.l10n.feedBackSms,
                  context: context,
                ),
              ),
              SocialIconButton(
                iconData: FontAwesomeIcons.envelopeOpen,
                onPressed: () async => AppLaunch.sendEmail(
                  'eldiiaralmazbekov@gmail.com',
                  snackBarText: context.l10n.feedBackSms,
                  context: context,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

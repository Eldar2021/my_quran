import 'package:flutter/material.dart';
import 'package:mq_app_theme/mq_app_theme.dart';

import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CircleAvatar(maxRadius: 50, child: Assets.icons.contactUs.svg()),
            const SizedBox(height: 10),
            Text(
              context.l10n.contactUsText,
              style: context.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

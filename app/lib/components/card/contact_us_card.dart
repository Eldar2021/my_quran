import 'package:flutter/material.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/theme/theme.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CircleAvatar(
              maxRadius: 50,
              child: Assets.icons.contactUs.svg(),
            ),
          ),
          ListTile(
            title: Text(
              context.l10n.contactUsText,
              style: context.textTheme.headlineSmall!.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';

class AboutUsVuew extends StatelessWidget {
  const AboutUsVuew({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      appBar: AppBar(
        title: Text(context.l10n.aboutUs),
        key: const Key(MqKeys.settingsAboutUsPage),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          const SizedBox(height: 20),
          Text(
            context.l10n.prophetLegacy,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Text(
            context.l10n.alImran,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';

class LangSettingsView extends StatelessWidget {
  const LangSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsLanguagePage),
        title: Text(context.l10n.loginPleaseSelectLang),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: SelectLangFromListViewBuilder(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:hatim/components/components.dart';

class LangSettingsView extends StatelessWidget {
  const LangSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings View'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: SelectLangFromListViewBuilder(),
      ),
    );
  }
}

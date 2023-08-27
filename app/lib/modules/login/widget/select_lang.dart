import 'package:flutter/material.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';

class SelectLang extends StatelessWidget {
  const SelectLang({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          context.l10n.loginPleaseSelectLang,
          style: TextStyle(fontSize: 24, color: colorScheme.onBackground),
        ),
        const SizedBox(height: 30),
        const Expanded(child: SelectLangFromListViewBuilder()),
      ],
    );
  }
}

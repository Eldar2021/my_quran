import 'package:flutter/material.dart';

import 'package:hatim/components/components.dart';

class SelectLang extends StatelessWidget {
  const SelectLang({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          'Please select Language',
          style: TextStyle(fontSize: 24, color: colorScheme.onBackground),
        ),
        const SizedBox(height: 30),
        const Expanded(child: SelectLangFromListViewBuilder()),
      ],
    );
  }
}

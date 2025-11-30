import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return RichText(
      text: TextSpan(
        text: title,
        style: prTextTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: '*',
            style: prTextTheme.bodyMedium?.copyWith(
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

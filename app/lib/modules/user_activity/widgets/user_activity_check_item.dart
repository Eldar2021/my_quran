import 'package:flutter/material.dart';

class UserActivityCheckItem extends StatelessWidget {
  const UserActivityCheckItem({
    required this.value,
    required this.title,
    super.key,
  });

  final bool value;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textTheme.titleSmall,
          ),
          const Spacer(),
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: null,
              checkColor: colorScheme.primary,
              activeColor: colorScheme.primary,
              fillColor: WidgetStateProperty.all(colorScheme.onPrimary),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

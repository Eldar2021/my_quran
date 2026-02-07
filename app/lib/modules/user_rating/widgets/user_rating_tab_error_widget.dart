import 'package:flutter/material.dart';

class UserRatingTabErrorWidget extends StatelessWidget {
  const UserRatingTabErrorWidget({
    required this.onRefresh,
    super.key,
  });

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 48,
          color: theme.colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          'An error occurred. Please try again.',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onRefresh,
          child: const Text('Try again'),
        ),
      ],
    );
  }
}

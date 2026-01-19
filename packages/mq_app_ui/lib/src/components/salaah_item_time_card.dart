import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class SalaahItemTimeCard extends StatelessWidget {
  const SalaahItemTimeCard({
    required this.salaahName,
    required this.timeOfClock,
    this.isActive = true,
    super.key,
  });

  final String salaahName;
  final String timeOfClock;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isActive
          ? colorScheme.primary
          : isDark
          ? colorScheme.surface.withValues(alpha: 0.5)
          : colorScheme.shadow.withValues(alpha: 0.5),
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.withWidth(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.withWidth(5),
          horizontal: context.withWidth(7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              salaahName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: prTextTheme.bodyMedium?.copyWith(
                color: (!isActive && isDark) ? colorScheme.onSurface : colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: context.withWidth(14),
              ),
            ),
            Text(
              timeOfClock,
              style: prTextTheme.bodyMedium?.copyWith(
                color: (!isActive && isDark) ? colorScheme.onSurface : colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: context.withWidth(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

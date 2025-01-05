import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class GradientDecoratedBox extends StatelessWidget {
  const GradientDecoratedBox({
    required this.child,
    this.borderRadius = 16,
    super.key,
  });

  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: AppColors.cardGradient(Theme.of(context)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 20,
          ),
        ],
      ),
      child: child,
    );
  }
}

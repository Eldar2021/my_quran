import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    this.boderWidth = 6,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.child,
    this.onPressed,
    super.key,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? disabledForegroundColor;
  final double boderWidth;
  final Widget? child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledForegroundColor: disabledForegroundColor,
        side: BorderSide(
          color: borderColor ?? colorScheme.primary,
          width: boderWidth,
        ),
        shape: const CircleBorder(),
        textStyle: prTextTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

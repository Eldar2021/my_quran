import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({this.label = 'Continue with Google', this.onPressed, super.key});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size.fromHeight(56),
        foregroundColor: colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: colorScheme.onSurface),
      ),
      onPressed: onPressed,
      label: Padding(padding: const EdgeInsets.only(left: 12), child: Text(label)),
      icon: Assets.icons.google.svg(width: 25),
    );
  }
}

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({this.label = 'Continue with Apple', this.onPressed, super.key});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size.fromHeight(56),
        foregroundColor: colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: colorScheme.onSurface),
      ),
      onPressed: onPressed,
      label: Padding(padding: const EdgeInsets.only(left: 12), child: Text(label)),
      icon: Assets.icons.apple.svg(width: 25, colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn)),
    );
  }
}

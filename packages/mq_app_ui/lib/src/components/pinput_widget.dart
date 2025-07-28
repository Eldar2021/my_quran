import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatelessWidget {
  const PinputWidget({
    super.key,
    this.controller,
    this.length = 4,
    this.keyboardType = TextInputType.number,
    this.itemPadding = 8,
    this.validator,
    this.onCompleted,
    this.errorText,
  });

  final TextEditingController? controller;
  final int length;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onCompleted;
  final String? errorText;
  final double itemPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Pinput(
      controller: controller,
      length: length,
      keyboardType: keyboardType,
      validator: validator,
      onCompleted: onCompleted,
      errorText: errorText,
      disabledPinTheme: pinTheme(theme),
      submittedPinTheme: pinTheme(theme).copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      errorPinTheme: pinTheme(theme).copyWith(
        textStyle: theme.textTheme.headlineMedium!.copyWith(color: theme.colorScheme.error),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.error),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      focusedPinTheme: pinTheme(theme).copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      defaultPinTheme: pinTheme(theme),
    );
  }

  PinTheme pinTheme(ThemeData theme) {
    return PinTheme(
      margin: EdgeInsets.all(itemPadding),
      textStyle: theme.textTheme.headlineMedium!.copyWith(color: theme.colorScheme.primary),
      constraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? theme.colorScheme.onSurface.withValues(alpha: 0.7)
              : theme.colorScheme.shadow.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LinkTextButton extends StatelessWidget {
  const LinkTextButton({required this.text, this.onPressed, this.textStyle, this.color, super.key});

  final String text;
  final void Function()? onPressed;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        foregroundColor: color ?? colorScheme.onSurface,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: (textStyle ?? prTextTheme.titleMedium)?.copyWith(
          color: color ?? colorScheme.onSurface,
          decoration: TextDecoration.underline,
          decorationColor: color ?? colorScheme.onSurface,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

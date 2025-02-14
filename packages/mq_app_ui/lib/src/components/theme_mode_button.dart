import 'package:flutter/material.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({required this.backgroundColor, required this.foregroundColor, this.onPressed, super.key});

  final Color backgroundColor;
  final Color foregroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fixedSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: onPressed,
      child: const Text('A'),
    );
  }
}

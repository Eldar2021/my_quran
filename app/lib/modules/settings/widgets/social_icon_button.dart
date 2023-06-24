import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    required this.iconData,
    required this.onPressed,
    super.key,
  });

  final IconData iconData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      isSelected: true,
      iconSize: 40,
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }
}

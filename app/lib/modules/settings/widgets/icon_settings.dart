import 'package:flutter/material.dart';
import 'package:my_quran/theme/theme.dart';

class IconSettings extends StatelessWidget {
  const IconSettings({
    required this.icon,
    super.key,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: context.colors.secondary,
    );
  }
}

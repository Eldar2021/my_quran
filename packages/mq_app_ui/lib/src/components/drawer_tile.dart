import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.subtitle,
    this.onLongPress,
    super.key,
  });

  final Widget icon;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: CircleAvatar(
        backgroundColor: colorScheme.onInverseSurface,
        child: icon,
      ),
      title: Text(title),
      subtitle: subtitle,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios),
    );
  }
}

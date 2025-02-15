import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({required this.icon, required this.title, this.onTap, super.key});

  final Widget icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(radius: 17, backgroundColor: colorScheme.onInverseSurface, child: icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}

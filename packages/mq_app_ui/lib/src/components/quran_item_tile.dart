import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class QuranItemTile extends StatelessWidget {
  const QuranItemTile({
    required this.index,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    this.onTap,
    this.trailing,
    super.key,
  });

  final int index;
  final String title;
  final String subtitle;
  final bool isSelected;
  final void Function()? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            if (isSelected)
              Assets.icons.islamicSymbolFill.svg(
                width: 50,
                height: 50,
                colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
              )
            else
              Assets.icons.heptagon.svg(
                width: 50,
                height: 50,
                colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
              ),
            Align(
              child: Text(
                '$index',
                style: prTextTheme.labelLarge?.copyWith(
                  color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle, style: prTextTheme.bodyLarge?.copyWith(color: colorScheme.primary)),
      trailing: trailing,
    );
  }
}

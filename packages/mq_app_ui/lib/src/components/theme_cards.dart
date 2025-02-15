import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class OrangeThemeCard extends StatelessWidget {
  const OrangeThemeCard({required this.isActive, required this.onChanged, this.title = 'Orange', super.key});

  final bool isActive;
  final String title;
  final void Function({bool? value}) onChanged;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return GradientDecoratedBox(
      useTomato: true,
      child: RadioListTile(
        activeColor: AppColors.tomato,
        title: Text(title, style: prTextTheme.titleMedium?.copyWith(color: AppColors.tomato)),
        value: true,
        groupValue: isActive,
        onChanged: (v) => onChanged(value: v),
      ),
    );
  }
}

class BlueThemeCard extends StatelessWidget {
  const BlueThemeCard({required this.isActive, required this.onChanged, this.title = 'Blue', super.key});

  final bool isActive;
  final String title;
  final void Function({bool? value}) onChanged;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return GradientDecoratedBox(
      useBlue: true,
      child: RadioListTile(
        activeColor: AppColors.darkslateblue,
        title: Text(title, style: prTextTheme.titleMedium?.copyWith(color: AppColors.darkslateblue)),
        value: false,
        groupValue: isActive,
        onChanged: (v) => onChanged(value: v),
      ),
    );
  }
}

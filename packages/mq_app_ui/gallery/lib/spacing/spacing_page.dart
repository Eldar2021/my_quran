import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SpacingPage());
  }

  @override
  Widget build(BuildContext context) {
    const spacingList = [
      SpacingItem(spacing: AppSpacing.xxxs, name: 'xxxs'),
      SpacingItem(spacing: AppSpacing.xxs, name: 'xxs'),
      SpacingItem(spacing: AppSpacing.xs, name: 'xs'),
      SpacingItem(spacing: AppSpacing.sm, name: 'sm'),
      SpacingItem(spacing: AppSpacing.md, name: 'md'),
      SpacingItem(spacing: AppSpacing.lg, name: 'lg'),
      SpacingItem(spacing: AppSpacing.xlg, name: 'xlg'),
      SpacingItem(spacing: AppSpacing.xxlg, name: 'xxlg'),
      SpacingItem(spacing: AppSpacing.xxxlg, name: 'xxxlg'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Spacing')),
      body: Center(
        child: ListView.builder(itemCount: spacingList.length, itemBuilder: (_, index) => spacingList[index]),
      ),
    );
  }
}

class SpacingItem extends StatelessWidget {
  const SpacingItem({required this.spacing, required this.name, super.key});

  final double spacing;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(color: AppColors.black, width: AppSpacing.xxs, height: AppSpacing.lg),
              Container(width: spacing, height: AppSpacing.lg, color: AppColors.tomato),
              Container(color: AppColors.black, width: AppSpacing.xxs, height: AppSpacing.lg),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(name),
        ],
      ),
    );
  }
}

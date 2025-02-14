import 'package:flutter/material.dart';
import 'package:gallery/typography/theme_typography_page.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class AppTypographyPage extends StatelessWidget {
  const AppTypographyPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AppTypographyPage());
  }

  @override
  Widget build(BuildContext context) {
    const textThemes = [
      TextItem(name: 'Display Large', style: AppTextStyles.displayLarge),
      TextItem(name: 'Display Medium', style: AppTextStyles.displayMedium),
      TextItem(name: 'Display Small', style: AppTextStyles.displaySmall),
      TextItem(name: 'Headline Large', style: AppTextStyles.headlineLarge),
      TextItem(name: 'Headline Medium', style: AppTextStyles.headlineMedium),
      TextItem(name: 'Headline Small', style: AppTextStyles.headlineSmall),
      TextItem(name: 'Title Large', style: AppTextStyles.titleLarge),
      TextItem(name: 'Title Medium', style: AppTextStyles.titleMedium),
      TextItem(name: 'Title Small', style: AppTextStyles.titleSmall),
      TextItem(name: 'Body Large', style: AppTextStyles.bodyLarge),
      TextItem(name: 'Body Medium', style: AppTextStyles.bodyMedium),
      TextItem(name: 'Body Small', style: AppTextStyles.bodySmall),
      TextItem(name: 'Label Large', style: AppTextStyles.labelLarge),
      TextItem(name: 'Label Medium', style: AppTextStyles.labelMedium),
      TextItem(name: 'Label Small', style: AppTextStyles.labelSmall),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Typography')),
      body: ListView.builder(
        itemCount: textThemes.length,
        itemBuilder: (context, index) {
          return textThemes[index];
        },
      ),
    );
  }
}

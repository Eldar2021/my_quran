import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class ThemeTypographyPage extends StatelessWidget {
  const ThemeTypographyPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ThemeTypographyPage());
  }

  @override
  Widget build(BuildContext context) {
    final primaryTextTheme = Theme.of(context).primaryTextTheme;
    final textTheme = Theme.of(context).textTheme;
    final primaryTextThemes = [
      TextItem(name: 'Display Large', style: primaryTextTheme.displayLarge),
      TextItem(name: 'Display Medium', style: primaryTextTheme.displayMedium),
      TextItem(name: 'Display Small', style: primaryTextTheme.displaySmall),
      TextItem(name: 'Headline Large', style: primaryTextTheme.headlineLarge),
      TextItem(name: 'Headline Medium', style: primaryTextTheme.headlineMedium),
      TextItem(name: 'Headline Small', style: primaryTextTheme.headlineSmall),
      TextItem(name: 'Title Large', style: primaryTextTheme.titleLarge),
      TextItem(name: 'Title Medium', style: primaryTextTheme.titleMedium),
      TextItem(name: 'Title Small', style: primaryTextTheme.titleSmall),
      TextItem(name: 'Body Large', style: primaryTextTheme.bodyLarge),
      TextItem(name: 'Body Medium', style: primaryTextTheme.bodyMedium),
      TextItem(name: 'Body Small', style: primaryTextTheme.bodySmall),
      TextItem(name: 'Label Large', style: primaryTextTheme.labelLarge),
      TextItem(name: 'Label Medium', style: primaryTextTheme.labelMedium),
      TextItem(name: 'Label Small', style: primaryTextTheme.labelSmall),
    ];

    final textThemes = [
      TextItem(name: 'Display Large', style: textTheme.displayLarge),
      TextItem(name: 'Display Medium', style: textTheme.displayMedium),
      TextItem(name: 'Display Small', style: textTheme.displaySmall),
      TextItem(name: 'Headline Large', style: textTheme.headlineLarge),
      TextItem(name: 'Headline Medium', style: textTheme.headlineMedium),
      TextItem(name: 'Headline Small', style: textTheme.headlineSmall),
      TextItem(name: 'Title Large', style: textTheme.titleLarge),
      TextItem(name: 'Title Medium', style: textTheme.titleMedium),
      TextItem(name: 'Title Small', style: textTheme.titleSmall),
      TextItem(name: 'Body Large', style: textTheme.bodyLarge),
      TextItem(name: 'Body Medium', style: textTheme.bodyMedium),
      TextItem(name: 'Body Small', style: textTheme.bodySmall),
      TextItem(name: 'Label Large', style: textTheme.labelLarge),
      TextItem(name: 'Label Medium', style: textTheme.labelMedium),
      TextItem(name: 'Label Small', style: textTheme.labelSmall),
    ];

    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Typography'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Primary Text Theme'),
              Tab(text: 'Text Theme'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: primaryTextThemes.length,
              itemBuilder: (context, index) {
                return primaryTextThemes[index];
              },
            ),
            ListView.builder(
              itemCount: textThemes.length,
              itemBuilder: (context, index) {
                return textThemes[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextItem extends StatelessWidget {
  const TextItem({required this.name, required this.style, super.key});

  final String name;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.lg),
      child: Text(name, style: style),
    );
  }
}

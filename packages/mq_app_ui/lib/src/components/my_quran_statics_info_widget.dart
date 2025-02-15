import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class MyQuranStaticsInfoWidget extends StatelessWidget {
  const MyQuranStaticsInfoWidget({
    this.count1 = '0',
    this.label1 = 'Total\nHatims',
    this.count2 = '0',
    this.label2 = 'All readed pages',
    this.count3 = '0',
    this.label3 = 'Your readed pages',
    super.key,
  });

  final String count1;
  final String label1;
  final String count2;
  final String label2;
  final String count3;
  final String label3;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GradientDecoratedBox(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 55,
                          child: CircularProgressIndicator(
                            value: 0.6,
                            backgroundColor: isDark ? colorScheme.inverseSurface : colorScheme.surface,
                          ),
                        ),
                        Center(
                          child: Text(count1, style: prTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(label1, textAlign: TextAlign.center, style: prTextTheme.titleSmall),
                ],
              ),
              const SizedBox(width: 16),
              VerticalDivider(thickness: 2, color: isDark ? colorScheme.inverseSurface : colorScheme.surface),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Assets.icons.quran.svg(
                          height: 28,
                          colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label2,
                              maxLines: 1,
                              style: prTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              count2,
                              maxLines: 1,
                              style: prTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Divider(thickness: 2, color: isDark ? colorScheme.inverseSurface : colorScheme.surface),
                    const Spacer(),
                    Row(
                      children: [
                        Assets.icons.prayerHand.svg(
                          height: 28,
                          colorFilter: ColorFilter.mode(colorScheme.onSurface, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              label3,
                              maxLines: 1,
                              style: prTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              count3,
                              maxLines: 1,
                              style: prTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

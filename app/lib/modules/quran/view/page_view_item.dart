import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';

class PageViewItem<T> extends StatelessWidget {
  const PageViewItem(this.items, {super.key});

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        if (item is MqJuzEntity) {
          return QuranItemTile(
            key: Key(MqKeys.quranReadJus(index)),
            index: item.juzNumber,
            title: '${item.juzNumber}-${context.l10n.juz}',
            subtitle: '${item.firstVerseId}-${item.lastVerseId}',
            onTap: () async {
              MqAnalytic.track(AnalyticKey.goQuranReadByJuz, params: {'juzId': item.id});
              context.goNamed(AppRouter.quranByJuz, pathParameters: {'juzNumber': item.juzNumber.toString()});
            },
          );
        } else if (item is MqSurahEntity) {
          return QuranItemTile(
            key: Key(MqKeys.quranReadSurah(index)),
            index: item.id,
            title: item.nameSimple,
            subtitle: item.nameArabic,
            onTap: () async {
              MqAnalytic.track(
                AnalyticKey.goQuranReadBySurah,
                params: {'surahId': item.id, 'surahName': item.nameSimple},
              );
              context.goNamed(AppRouter.quranBySurah, pathParameters: {'surahNumber': item.id.toString()});
            },
          );
        }
        return const SizedBox();
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 0.5, color: colorScheme.onSurface.withValues(alpha: 0.1));
      },
    );
  }
}

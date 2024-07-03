import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class PageViewItem<T> extends StatelessWidget {
  const PageViewItem(this.items, {super.key});

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        if (item is JuzEntity) {
          return Card(
            child: ListTile(
              key: Key(MqKeys.quranReadJus(index)),
              minLeadingWidth: 10,
              leading: Text('${item.id}'),
              title: Text('${item.id}-${context.l10n.juz}'),
              subtitle: Text(item.name),
              onTap: () async {
                context.read<MqAnalytic>().track(AnalyticKey.quranReadJus);
                final pages = <int>[];
                for (var i = item.pages.first; i <= item.pages.last; i++) {
                  pages.add(i);
                }
                pages.sort();
                context.goNamed(
                  AppRouter.read,
                  pathParameters: {
                    'pages': pages.toString(),
                    'isHatim': true.toString(),
                  },
                );
              },
            ),
          );
        } else if (item is SurahEntity) {
          return Card(
            child: ListTile(
              key: Key(MqKeys.quranReadSurah(index)),
              minLeadingWidth: 10,
              leading: Text('${item.id}'),
              title: Text(item.arabic),
              subtitle: Text(item.name),
              onTap: () async {
                context.read<MqAnalytic>().track(AnalyticKey.quranReadSurah);
                final pages = <int>[];
                for (var i = item.pages.first; i <= item.pages.last; i++) {
                  pages.add(i);
                }
                pages.sort();
                context.goNamed(
                  AppRouter.read,
                  pathParameters: {
                    'pages': pages.toString(),
                    'isHatim': true.toString(),
                  },
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

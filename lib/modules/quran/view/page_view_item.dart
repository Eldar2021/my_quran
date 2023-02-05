import 'package:flutter/material.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

class PageViewItem<T> extends StatelessWidget {
  const PageViewItem(this.items, {super.key});

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      key: const Key('list-view-builder-juz-surah'),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        if (item is Juz) {
          return Card(
            child: ListTile(
              key: Key('quran-view-${item.id}-juz'),
              minLeadingWidth: 10,
              leading: Text('${item.id}'),
              title: Text(item.name),
              onTap: () async {
                final pages = <int>[];
                for (var i = item.pages.first; i <= item.pages.last; i++) {
                  pages.add(i);
                }
                pages.sort();
                await Navigator.pushNamed(
                  context,
                  AppRouter.read,
                  arguments: {'pages': pages, 'isHatim': false},
                );
              },
            ),
          );
        } else if (item is Surah) {
          return Card(
            child: ListTile(
              key: Key('quran-view-${item.id}-surah'),
              minLeadingWidth: 10,
              leading: Text('${item.id}'),
              title: Text(item.arabic),
              subtitle: Text(item.name),
              onTap: () async {
                final pages = <int>[];
                for (var i = item.pages.first; i <= item.pages.last; i++) {
                  pages.add(i);
                }
                pages.sort();
                await Navigator.pushNamed(
                  context,
                  AppRouter.read,
                  arguments: {'pages': pages, 'isHatim': false},
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

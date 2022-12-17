import 'package:flutter/material.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

class PageViewItem<T> extends StatelessWidget {
  const PageViewItem(this.items, {super.key});

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key('list-view-builder-juz-surah'),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        if (item is Juz) {
          return Card(
            child: ListTile(
              key: Key('${item.id}-juz'),
              leading: Text('${item.id}'),
              title: Text(item.name),
              onTap: () => Navigator.pushNamed(context, AppRouter.read, arguments: item.pages),
            ),
          );
        } else if (item is Surah) {
          return Card(
            child: ListTile(
              key: Key('${item.id}-surah'),
              leading: Text('${item.id}'),
              title: Text(item.arabic),
              subtitle: Text(item.name),
              onTap: () => Navigator.pushNamed(context, AppRouter.read, arguments: item.pages),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

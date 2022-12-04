import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

class PageViewItem<T> extends StatelessWidget {
  const PageViewItem(this.items, {super.key});

  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        if (item is Juz) {
          return Card(
            child: ListTile(
              leading: Text('${item.id}'),
              title: Text(item.name),
              onTap: () => context.goNamed(RouterConst.read, extra: item.pages),
            ),
          );
        } else if (item is Surah) {
          return Card(
            child: ListTile(
              leading: Text('${item.id}'),
              title: Text(item.arabic),
              subtitle: Text(item.name),
              onTap: () => context.goNamed(RouterConst.read, extra: item.pages),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

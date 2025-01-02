import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News Example Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      ListItem(
        icon: const Icon(Icons.color_lens),
        title: const Text('Colors'),
        subtitle: const Text('All of the predefined colors'),
        // onTap: () => Navigator.of(context).push<void>(ColorsPage.route()),
        onTap: () {},
      ),
      ListItem(
        icon: const Icon(Icons.text_format),
        title: const Text('Typography'),
        subtitle: const Text('All of the predefined text styles'),
        // onTap: () => Navigator.of(context).push<void>(TypographyPage.route()),
        onTap: () {},
      ),
      ListItem(
        icon: const Icon(Icons.border_vertical),
        title: const Text('Spacing'),
        subtitle: const Text('All of the predefined spacings'),
        // onTap: () => Navigator.of(context).push<void>(SpacingPage.route()),
        onTap: () {},
      ),
      ListItem(
        icon: const Icon(Icons.widgets),
        title: const Text('Widgets'),
        subtitle: const Text('All of the predefined widgets'),
        // onTap: () => Navigator.of(context).push<void>(WidgetsPage.route()),
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Quran Gallery App'),
      ),
      body: ListView.separated(
        itemCount: pages.length,
        itemBuilder: (_, index) => pages[index],
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final Icon icon;
  final Text title;
  final Text subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconTheme(
        data: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
        child: icon,
      ),
      title: title,
      subtitle: subtitle,
      trailing: const Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}

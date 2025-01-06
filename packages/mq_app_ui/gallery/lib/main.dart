import 'package:flutter/material.dart';
import 'package:gallery/body/bg_image_body.dart';
import 'package:gallery/colors/app_colors_view.dart';
import 'package:gallery/colors/theme_colors_view.dart';
import 'package:gallery/components/app_components_page.dart';
import 'package:gallery/components/story_view.dart';
import 'package:gallery/components/ui_components_page.dart';
import 'package:gallery/show/show_contents_page.dart';
import 'package:gallery/spacing/spacing_page.dart';
import 'package:gallery/typography/app_typography_page.dart';
import 'package:gallery/typography/theme_typography_page.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_storage/mq_storage.dart';

MqAppUiNotifier? themeProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await PreferencesStorage.getInstance();

  themeProvider = MqAppUiNotifier(storage)..init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeProvider!,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'MyQuran Example Gallery',
          theme: themeProvider!.theme.themeData,
          home: const RootPage(),
        );
      },
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
        title: const Text('Theme Colors'),
        subtitle: const Text('All theme colors'),
        onTap: () => Navigator.of(context).push<void>(
          ThemeColorsView.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.color_lens),
        title: const Text('App Colors'),
        subtitle: const Text('All app colors'),
        onTap: () => Navigator.of(context).push<void>(
          AppColorsView.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.text_format),
        title: const Text('Theme Typography'),
        subtitle: const Text('All of the predefined theme text styles'),
        onTap: () => Navigator.of(context).push<void>(
          ThemeTypographyPage.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.text_format),
        title: const Text('App Typography'),
        subtitle: const Text('All of the predefined app text styles'),
        onTap: () => Navigator.of(context).push<void>(
          AppTypographyPage.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.border_vertical),
        title: const Text('Spacing'),
        subtitle: const Text('All of the predefined spacings'),
        onTap: () => Navigator.of(context).push<void>(
          SpacingPage.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.widgets),
        title: const Text('UI Components'),
        subtitle: const Text('All of the predefined components'),
        onTap: () => Navigator.of(context).push<void>(
          UiComponentsPage.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.widgets),
        title: const Text('Body Image'),
        subtitle: const Text('All of the predefined body'),
        onTap: () => Navigator.of(context).push<void>(
          BgImageBodyPage.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.pest_control_rodent_sharp),
        title: const Text('App Components'),
        subtitle: const Text('All of the app components'),
        onTap: () => Navigator.of(context).push<void>(
          AppComponentsPage.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.add_reaction_outlined),
        title: const Text('Show Contents'),
        subtitle: const Text('All of the show contents'),
        onTap: () => Navigator.of(context).push<void>(
          ShowContentsPage.route(),
        ),
      ),
      ListItem(
        icon: const Icon(Icons.storage),
        title: const Text('Story Contents'),
        subtitle: const Text('All of the store contents'),
        onTap: () => Navigator.of(context).push<void>(
          StoryView.route(),
        ),
      ),
      Wrap(
        children: [
          TextButton(
            onPressed: () {
              themeProvider!.changeTheme(
                MqAppUiType.orange,
              );
            },
            child: const Text('Orange'),
          ),
          TextButton(
            onPressed: () {
              themeProvider!.changeTheme(
                MqAppUiType.orangeDark,
              );
            },
            child: const Text('OrangeDark'),
          ),
          TextButton(
            onPressed: () {
              themeProvider!.changeTheme(
                MqAppUiType.blue,
              );
            },
            child: const Text('Blue'),
          ),
          TextButton(
            onPressed: () {
              themeProvider!.changeTheme(
                MqAppUiType.blueDark,
              );
            },
            child: const Text('BlueDark'),
          ),
        ],
      ),
      const SizedBox(height: 100),
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

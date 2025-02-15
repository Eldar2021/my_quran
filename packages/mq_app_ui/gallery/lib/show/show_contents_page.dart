import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class ShowContentsPage extends StatefulWidget {
  const ShowContentsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ShowContentsPage());
  }

  @override
  State<ShowContentsPage> createState() => _ShowContentsPageState();
}

class _ShowContentsPageState extends State<ShowContentsPage> {
  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Show Contents')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text('Show amen', style: prTextTheme.titleMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  MqAlertDialogs.showAmen<void>(
                    context: context,
                    backgroundColor: colorScheme.surface,
                    foregroundColor: colorScheme.onSurface,
                    onPressed: () {},
                  );
                },
                child: const Text('Male'),
              ),
              TextButton(
                onPressed: () {
                  MqAlertDialogs.showAmen<void>(
                    context: context,
                    backgroundColor: colorScheme.surface,
                    foregroundColor: colorScheme.onSurface,
                    gender: MqAppUiGender.famale,
                    onPressed: () {},
                  );
                },
                child: const Text('Famale'),
              ),
              TextButton(
                onPressed: () {
                  MqAlertDialogs.showAmen<void>(
                    context: context,
                    backgroundColor: colorScheme.surface,
                    foregroundColor: colorScheme.onSurface,
                    gender: MqAppUiGender.unknown,
                    onPressed: () {},
                  );
                },
                child: const Text('Unknown'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Text('Link Text button', style: prTextTheme.titleMedium),
          LinkTextButton(text: 'Link Text', onPressed: () {}),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Text('Bottom Sheets', style: prTextTheme.titleMedium),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  MqBottomSheets.showConfirmSheet<void>(
                    context: context,
                    title: 'Logout',
                    content: 'Are you sure you want to logout?',
                    confirmText: 'Yes, logout',
                    onConfirm: () => Navigator.pop(context),
                    onCancel: () => Navigator.pop(context),
                  );
                },
                child: const Text('Logout'),
              ),
              TextButton(
                onPressed: () {
                  MqBottomSheets.showConfirmSheet<void>(
                    context: context,
                    title: 'Delete account',
                    content: 'Are you sure you want to delete this account?',
                    confirmText: 'Yes, delete',
                    onConfirm: () => Navigator.pop(context),
                    onCancel: () => Navigator.pop(context),
                  );
                },
                child: const Text('Delete account'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Text('Popup Menu', style: prTextTheme.titleMedium),
        ],
      ),
    );
  }
}

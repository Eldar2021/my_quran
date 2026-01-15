import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';

class HatimCrudSuccesView extends StatelessWidget {
  const HatimCrudSuccesView({
    required this.title,
    this.description,
    super.key,
  });

  final String title;
  final String? description;

  static void show({
    required BuildContext context,
    required String title,
    String? description,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => HatimCrudSuccesView(
          title: title,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary,
              ),
              child: Icon(
                Icons.check_outlined,
                size: 50,
                color: colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: prTextTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              description ?? '',
              textAlign: TextAlign.center,
              style: prTextTheme.bodyLarge,
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () => context.goNamed(AppRouter.home),
          child: Text(context.l10n.backToHome),
        ),
      ),
    );
  }
}

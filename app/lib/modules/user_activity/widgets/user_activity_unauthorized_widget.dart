import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityUnauthorizedWidget extends StatelessWidget {
  const UserActivityUnauthorizedWidget(this.groupedData, {super.key});

  final Map<DateTime, List<UserActivityModel>> groupedData;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 145,
      width: double.infinity,
      child: Card.outlined(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: UserActivityCardList(groupedData),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: switch (Theme.of(context).brightness) {
                    Brightness.dark => colorScheme.shadow.withValues(alpha: 0.9),
                    Brightness.light => colorScheme.shadow.withValues(alpha: 0.5),
                  },
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: colorScheme.onPrimary,
                      ),
                      Text(
                        context.l10n.loginToSeeActivity,
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(AppRouter.loginWihtSoccial);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          context.l10n.login,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

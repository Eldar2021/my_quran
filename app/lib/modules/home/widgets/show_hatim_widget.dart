import 'package:flutter/material.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';

class ShowHatimWidget {
  static Future<T?> showHatimSheet<T>({
    required BuildContext context,
    List<MqHatimsModel> hatim = const [],
    String? confirmKey,
    String? cancelKey,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final prTextTheme = Theme.of(context).primaryTextTheme;
        final colorScheme = Theme.of(context).colorScheme;
        final maxHeight = MediaQuery.of(context).size.height - 120;

        return Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 57,
                height: 6,
                decoration: BoxDecoration(
                  color: colorScheme.inverseSurface,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                context.l10n.myHatims,
                style: prTextTheme.titleLarge,
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: hatim.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  itemBuilder: (context, index) {
                    final item = hatim[index];
                    final titleText = item.type == 'GENERAL' ? context.l10n.generalHatim : item.title;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GradientDecoratedBox(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pop();
                            MqAnalytic.track(AnalyticKey.goHatim);
                            context.goNamedIfAuthenticated(
                              AppRouter.hatim,
                              pathParameters: {'hatimId': item.id},
                            );
                          },
                          contentPadding: const EdgeInsets.all(16),
                          leading: Assets.icons.quran.svg(
                            colorFilter: ColorFilter.mode(
                              colorScheme.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: Text(
                            '$titleText',
                            style: prTextTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

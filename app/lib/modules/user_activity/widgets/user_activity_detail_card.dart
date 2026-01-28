import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityDetailCard extends StatelessWidget {
  const UserActivityDetailCard(this.data, {super.key});

  final Map<DateTime, List<UserActivityModel>> data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final key = data.keys.elementAt(index);
        final value = data[key]!;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ExpansionTile(
            backgroundColor: colorScheme.surface,
            collapsedBackgroundColor: colorScheme.surface,
            title: Text(
              DateFormat('MMMM yyyy', locale.languageCode).format(key).toUpperCase(),
              style: textTheme.titleMedium,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            childrenPadding: const EdgeInsets.symmetric(vertical: 8),
            children: value.map((e) {
              return Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('dd MMMM', locale.languageCode).format(e.date),
                      style: textTheme.titleMedium,
                    ),
                    UserActivityCheckItem(
                      value: e.openedApp,
                      title: context.l10n.appOpened,
                    ),
                    UserActivityCheckItem(
                      value: e.quranReadedPagesCount > 0,
                      title: context.l10n.quranRead(e.quranReadedPagesCount),
                    ),
                    UserActivityCheckItem(
                      value: e.listenedQuranSeconds > 0,
                      title: context.l10n.quranListened,
                    ),
                    UserActivityCheckItem(
                      value: e.fajrDone,
                      title: context.l10n.fajr,
                    ),
                    UserActivityCheckItem(
                      value: e.zuhrDone,
                      title: context.l10n.zuhr,
                    ),
                    UserActivityCheckItem(
                      value: e.asrDone,
                      title: context.l10n.asr,
                    ),
                    UserActivityCheckItem(
                      value: e.maghribDone,
                      title: context.l10n.maghrib,
                    ),
                    UserActivityCheckItem(
                      value: e.ishaDone,
                      title: context.l10n.isya,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

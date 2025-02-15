import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => QuranCubit(mqQuranRepository: context.read<MqQuranRepository>()),
        child: const QuranBody(),
      ),
    );
  }
}

class QuranBody extends StatelessWidget {
  const QuranBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.quaranReadInitPage),
        title: Text(context.l10n.quran),
        bottom: TabBar.secondary(
          labelColor: colorScheme.primary,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
          labelStyle: prTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          dividerColor: colorScheme.surfaceBright,
          dividerHeight: 3,
          tabs: [
            Tab(key: const Key(MqKeys.quaranReadJuzs), text: context.l10n.juzas),
            Tab(key: const Key(MqKeys.quaranReadSurahs), text: context.l10n.surahs),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          PageViewItem<MqJuzEntity>(context.read<QuranCubit>().getJuz()),
          PageViewItem<MqSurahEntity>(context.read<QuranCubit>().getSurah()),
        ],
      ),
    );
  }
}

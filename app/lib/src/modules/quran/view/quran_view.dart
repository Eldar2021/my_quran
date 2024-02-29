import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/src/src.dart';


class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => QuranCubit(),
        child: const QuranBody(),
      ),
    );
  }
}

class QuranBody extends StatelessWidget {
  const QuranBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.quaranReadInitPage),
        title: Text(context.l10n.quran),
        bottom: TabBar(
          indicatorColor: context.colors.primary,
          labelColor: context.colors.onSurfaceVariant,
          tabs: [
            PageViewCard(page: context.l10n.juzs, key: const Key(MqKeys.quaranReadJuzs)),
            PageViewCard(page: context.l10n.surahs, key: const Key(MqKeys.quaranReadSurahs)),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          PageViewItem<Juz>(context.read<QuranCubit>().juzs),
          PageViewItem<Surah>(context.read<QuranCubit>().surahs),
        ],
      ),
    );
  }
}

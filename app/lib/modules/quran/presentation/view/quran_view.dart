import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          RepositoryProvider<QuranRepository>(
            create: (context) => QuranRepositoryImpl(
              JuzLocalDataSource(),
              SurahLocalDataSource(),
            ),
          ),
          BlocProvider(
            create: (context) => QuranCubit(
              getJuzUseCase: GetJuzUseCase(
                context.read<QuranRepository>(),
              ),
              getSurahsUseCase: GetSurahsUseCase(
                context.read<QuranRepository>(),
              ),
            ),
          ),
        ],
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
          PageViewItem<JuzEntity>(context.read<QuranCubit>().getJuz()),
          PageViewItem<SurahEntity>(context.read<QuranCubit>().getSurah()),
        ],
      ),
    );
  }
}

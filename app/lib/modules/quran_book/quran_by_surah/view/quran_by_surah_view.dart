import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBySurahView extends StatelessWidget {
  const QuranBySurahView(this.surahNumber, {super.key});

  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuranBookThemeCubit(
            readThemeRepository: context.read<ReadThemeRepository>(),
          )..initializeTheme(),
        ),
        BlocProvider(
          create: (context) => QuranBookBySurahCubit(
            repository: context.read<MqQuranRepository>(),
            surahNumber: surahNumber,
          ),
        ),
      ],
      child: const _QuranBySurahView(),
    );
  }
}

class _QuranBySurahView extends StatefulWidget {
  const _QuranBySurahView();

  @override
  State<_QuranBySurahView> createState() => __QuranBySurahViewState();
}

class __QuranBySurahViewState extends State<_QuranBySurahView> {
  late final MqSurahEntity _surahEntity;

  @override
  void initState() {
    _surahEntity = context.read<QuranBookBySurahCubit>().getSurahData();
    context.read<QuranBookBySurahCubit>().getData('uthmanic');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<QuranBookThemeCubit>();
    return Scaffold(
      backgroundColor: themeCubit.state.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            stretch: true,
            centerTitle: true,
            backgroundColor: themeCubit.state.bgColor,
            foregroundColor: themeCubit.state.frColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: FittedBox(
                child: Text(
                  _surahEntity.nameSimple,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.qpcUthmanicHafs,
                    fontSize: 26,
                    color: themeCubit.state.frColor,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                key: const Key(MqKeys.quranReadSettings),
                onPressed: () {
                  MqAnalytic.track(AnalyticKey.tapQuranReadSettings);
                  MqBottomSheets.showReadSettingsSheet<void>(
                    context: context,
                    backgroundColor: themeCubit.state.bgColor,
                    child: BlocProvider.value(
                      value: context.read<ReadThemeCubit>(),
                      child: const ChangeReadThemeSheetContent(),
                    ),
                  );
                },
                icon: const Icon(Icons.tune),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: Text(_surahEntity.name),
      // ),
    );
  }
}

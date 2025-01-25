import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

class ReadView extends StatelessWidget {
  const ReadView(
    this.pages, {
    required this.isHatim,
    super.key,
  });

  final List<int> pages;
  final bool isHatim;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReadCubit(
            MqQuranRepositoryImpl(
              context.read<AppConfig>().isMockData
                  ? const MqQuranLocalDataSourceMock()
                  : MqQuranLocalDataSourceImpl(context.read<PreferencesStorage>()),
              context.read<AppConfig>().isMockData
                  ? MqQuranRemoteDataSourceMock()
                  : MqQuranRemoteDataSourceImpl(context.read<MqRemoteClient>()),
            ),
          ),
        ),
        RepositoryProvider<ReadThemeRepository>(
          create: (context) => ReadThemeRepositoryImpl(
            LocalThemeDataSourceImpl(context.read<PreferencesStorage>()),
          ),
        ),
        BlocProvider(
          create: (context) => ReadThemeCubit(
            readThemeRepository: ReadThemeRepositoryImpl(
              LocalThemeDataSourceImpl(
                context.read<PreferencesStorage>(),
              ),
            ),
          ),
        ),
      ],
      child: ReadUI(pages: pages, isHatim: isHatim),
    );
  }
}

class ReadUI extends StatelessWidget {
  const ReadUI({
    required this.pages,
    required this.isHatim,
    super.key,
  });

  final List<int> pages;
  final bool isHatim;

  @override
  Widget build(BuildContext context) {
    final readThemeCubit = context.watch<ReadThemeCubit>();
    return Scaffold(
      backgroundColor: readThemeCubit.state.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            stretch: true,
            centerTitle: true,
            backgroundColor: readThemeCubit.state.bgColor,
            foregroundColor: readThemeCubit.state.frColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: FittedBox(
                child: Text(
                  MqQuranStatic.bismallah,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.qpcUthmanicHafs,
                    fontSize: 26,
                    color: readThemeCubit.state.frColor,
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
                    backgroundColor: readThemeCubit.state.bgColor,
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
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: readThemeCubit.state.verticalSpaceSize,
              horizontal: readThemeCubit.state.horizontalSpaceSize,
            ),
            sliver: PaginationView(pages, isHatim: isHatim),
          ),
        ],
      ),
    );
  }
}

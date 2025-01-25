import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:mq_storage/mq_storage.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

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
                  AppBottomSheet.showBottomSheet<void>(
                    context,
                    BlocProvider.value(
                      value: context.read<ReadThemeCubit>(),
                      child: const ChangeReadTheme(),
                    ),
                    initialChildSize: 0.7,
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

class ChangeReadTheme extends StatelessWidget {
  const ChangeReadTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final readThemeCubit = context.watch<ReadThemeCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.textSize,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Slider(
          min: 8,
          max: 40,
          value: readThemeCubit.state.textSize,
          onChanged: (v) => context.read<ReadThemeCubit>().changeTextSize(v),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.verticalSpace,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Slider(
          max: 140,
          value: readThemeCubit.state.verticalSpaceSize,
          onChanged: (v) => context.read<ReadThemeCubit>().changeVerticalSpace(v),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.horizontalSpace,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Slider(
          max: 140,
          value: readThemeCubit.state.horizontalSpaceSize,
          onChanged: (v) => context.read<ReadThemeCubit>().changeHorizontalSpace(v),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            l10n.screenTheme,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            ReadThemeData.bgReadThemeColor.length,
            (index) => InkWell(
              onTap: () => context.read<ReadThemeCubit>().changeMode(index),
              child: Material(
                color: ReadThemeData.bgReadThemeColor[index],
                type: MaterialType.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(),
                ),
                child: SizedBox(
                  width: 70,
                  height: 40,
                  child: Center(
                    child: Text('A', style: TextStyle(color: ReadThemeData.frReadThemeColor[index], fontSize: 22)),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              key: const Key(MqKeys.quranReadSettingsBack),
              onPressed: () => context.pop(),
              child: Text(l10n.cancel),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              key: const Key(MqKeys.quranReadSettingsSave),
              onPressed: () async {
                await context.read<ReadThemeCubit>().saveChanges();
                if (context.mounted) context.pop();
              },
              child: Text(l10n.saveChanges),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}

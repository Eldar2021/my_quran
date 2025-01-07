import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:my_quran/config/config.dart';

import 'package:my_quran/core/core.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/utils/show/snackbars.dart';

const sources = [
  'https://t3.ftcdn.net/jpg/05/68/99/80/360_F_568998040_m42feFA9RajqmuR5DTlWwox44fxE3MOi.jpg',
  'https://t3.ftcdn.net/jpg/07/02/55/16/360_F_702551695_zBR0B1IrgGCJdgZbYE6dzlExKhAxD4OC.jpg',
  'https://thumbs.dreamstime.com/b/closeup-holy-quran-captured-near-sacred-kaaba-mecca-highlighting-its-spiritual-significance-ai-generated-image-329385127.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaczS5PI_ePL2HwRhlEq1PPZjpLFw3PY3D5w&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-IlJBNJLlv1cdFJ7xVWMkAjfk-mSWAJFvCu2HctMMRBRRyphoZTe0wjbkUl75fR97odM&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqILNo55rnX2dLPvHPlu0Rr3_KkjM_ajDTEQ&s',
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    final homeCubit = context.read<HomeCubit>();
    final authCubit = context.read<AuthCubit>();
    final user = authCubit.state.user;
    final validName = user?.username.replaceAll(RegExp(r'\W+'), '_');
    if (homeCubit.state.status != FetchStatus.success && user != null) {
      MqCrashlytics.setUserIdentifier(validName ?? user.accessToken);
      MqAnalytic.setUserProperty(validName ?? user.accessToken);
      homeCubit.getData();
    }
    context.read<LocationCubit>().fetchLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(
        closeDrawer: () {
          _scaffoldKey.currentState?.closeDrawer();
        },
      ),
      appBar: AppBar(
        title: const Text('Hello'),
        centerTitle: true,
        leading: IconButton(
          key: const Key(MqKeys.settings),
          padding: const EdgeInsets.only(left: 24),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Assets.icons.settingsBurger.svg(),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 24),
            onPressed: () {
              AppSnackbar.showSnackbar(
                context,
                'This feature will be added in the future...',
              );
            },
            icon: Assets.icons.qyblaDirection.svg(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          MqAnalytic.track(AnalyticKey.refreshHomePage);
          await context.read<HomeCubit>().getData();
        },
        child: ListView(
          key: const Key(MqKeys.homeListView),
          children: [
            const SizedBox(height: 20),
            MqStoryItemsWidget(
              listHeight: 142,
              buttonWidth: 70,
              buttonSpacing: 14,
              items: sources.asMap().entries.map((e) {
                final idx = e.key;
                final v = e.value;
                return MqStoryItem(
                  id: '$idx',
                  cardImageLink: v,
                  cardLabel: 'MyQuran\nNews',
                  storyPagesImages: sources,
                  storyPageDuration: List.generate(
                    sources.length,
                    (index) => const Duration(seconds: 1),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const MqSalaahTimeWidget(),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(
                'Select below the pages that no one has taken yet',
                style: prTextTheme.bodyMedium,
              ),
              trailing: TextButton(
                onPressed: () {},
                child: Text(context.l10n.share),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return MyQuranStaticsInfoWidget(
                    count1: '${state.homeModel?.allDoneHatims ?? 0}',
                    count2: '${state.homeModel?.allDonePages ?? 0}',
                    count3: '${state.homeModel?.donePages ?? 0}',
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                builder: (context, state) {
                  return ElevatedButton(
                    key: const Key(MqKeys.participantToHatim),
                    onPressed: state.isHatimEnable ? _onJoinToHatim : null,
                    child: Text(context.l10n.joinToHatim),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onJoinToHatim() {
    MqAnalytic.track(AnalyticKey.goHatim);
    context.goNamedIfAuthenticated(AppRouter.hatim);
  }
}

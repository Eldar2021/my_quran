import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/config/config.dart';

import 'package:my_quran/core/core.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    final l10n = context.l10n;
    final homeCubit = context.watch<HomeCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: GestureDetector(
            onTap: () => context.goNamed(AppRouter.settingsPage),
            child: Assets.icons.settingsBurger.svg(key: const Key(MqKeys.settings)),
          ),
        ),
        actions: [
          Text('السلام عليكم', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.all(6),
            child: IconButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'This feature will be added in the future...',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Color(0xff1C274C),
                  padding: EdgeInsets.only(bottom: 30, top: 10, left: 10),
                ),
              ),
              icon: Assets.icons.qibla.svg(),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          MqAnalytic.track(AnalyticKey.refreshHomePage);
          await context.read<HomeCubit>().getData();
        },
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF5F5F5),
                  Color(0xFFFFDEEA),
                  Colors.white,
                ],
                stops: [0.0, 0.5, 0.6],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView(
              key: const Key(MqKeys.homeListView),
              children: [
                const PrayTimeWidget(),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(452),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(255, 222, 234, 0.50),
                            Color.fromRGBO(236, 242, 255, 0),
                            Color.fromRGBO(236, 242, 255, 0),
                            Color.fromRGBO(236, 242, 255, 0),
                            Color.fromRGBO(255, 222, 234, 0.50),
                          ],
                          stops: [0.01, 0.2, 0.5, 0.85, 0.9],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Assets.icons.quranBook.svg(),
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffEDD6DE).withOpacity(0.17),
                              borderRadius: BorderRadius.circular(23),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        l10n.homeAllHatim,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff1C274C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${homeCubit.state.homeModel?.allDoneHatims ?? 0}',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Color(0xff1C274C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        l10n.allDonePages,
                                        style: const TextStyle(fontSize: 16, color: Color(0xff1C274C)),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      '${homeCubit.state.homeModel?.allDonePages ?? 0}',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Color(0xff1C274C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        l10n.homeUserReadAllPage,
                                        style: const TextStyle(fontSize: 16, color: Color(0xff1C274C)),
                                      ),
                                    ),
                                    Text(
                                      '${homeCubit.state.homeModel?.donePages ?? 0}',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Color(0xff1C274C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                            builder: (context, state) {
                              return GestureDetector(
                                key: const Key(MqKeys.participantToHatim),
                                onTap: state.isHatimEnable ? _onJoinToHatim : null,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFF57181),
                                        Color(0xFF9851B1),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        l10n.homeGoHatim,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Assets.icons.goRight.svg(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onJoinToHatim() {
    MqAnalytic.track(AnalyticKey.goHatim);
    context.goNamed(AppRouter.hatim);
  }
}

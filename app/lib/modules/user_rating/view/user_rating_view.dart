import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/modules/modules.dart';

class UserRatingView extends StatefulWidget {
  const UserRatingView({super.key});

  @override
  State<UserRatingView> createState() => _UserRatingViewState();
}

class _UserRatingViewState extends State<UserRatingView> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final UserRatingBloc _userRatingByWorldBloc;
  late final UserRatingBloc _userRatingByCountryBloc;

  @override
  void initState() {
    final userId = context.read<AuthCubit>().state.auth?.key ?? '';
    _userRatingByWorldBloc = UserRatingBloc(
      userId: userId,
      repository: context.read<AuthRepository>(),
      areaType: AreaType.world,
    );
    _userRatingByCountryBloc = UserRatingBloc(
      userId: userId,
      repository: context.read<AuthRepository>(),
      areaType: AreaType.country,
    );
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('Ratings'),
                centerTitle: true,
                pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar.secondary(
                  controller: _tabController,
                  labelColor: colorScheme.primary,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
                  labelStyle: prTextTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  dividerColor: colorScheme.surfaceBright,
                  tabs: const [
                    Tab(text: 'World'),
                    Tab(text: 'Country'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocProvider.value(
              value: _userRatingByWorldBloc,
              child: const UserRatingTabView(AreaType.world),
            ),
            BlocProvider.value(
              value: _userRatingByCountryBloc,
              child: const UserRatingTabView(AreaType.country),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: _tabController,
        builder: (context, child) {
          return BlocBuilder<UserRatingBloc, UserRatingState>(
            bloc: _tabController.index == 0 ? _userRatingByWorldBloc : _userRatingByCountryBloc,
            builder: (context, state) {
              if (state.ownerData != null) {
                return SafeArea(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: colorScheme.primary)),
                    ),
                    child: UserRatingOwnerDataWidget(
                      ownerData: state.ownerData!,
                      user: context.read<AuthCubit>().state.auth!.user,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

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

class _UserRatingViewState extends State<UserRatingView> {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Ratings'),
                centerTitle: true,
                pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar.secondary(
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
            ];
          },
          body: TabBarView(
            children: [
              BlocProvider.value(
                value: _userRatingByWorldBloc,
                child: const UserRatingTabView(),
              ),
              BlocProvider.value(
                value: _userRatingByCountryBloc,
                child: const UserRatingTabView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

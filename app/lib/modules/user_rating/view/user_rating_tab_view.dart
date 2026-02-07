import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/modules/modules.dart';

class UserRatingTabView extends StatefulWidget {
  const UserRatingTabView(this.areaType, {super.key});

  final AreaType areaType;

  @override
  State<UserRatingTabView> createState() => _UserRatingTabViewState();
}

class _UserRatingTabViewState extends State<UserRatingTabView> {
  late final bool _showSelectCountryState;
  late final UserRatingBloc _bloc;
  late final ValueNotifier<PeriodType> selectedPeriod;

  @override
  void initState() {
    _bloc = context.read<UserRatingBloc>();
    selectedPeriod = ValueNotifier(PeriodType.weekly);
    final country = context.read<AuthCubit>().state.auth?.user.country;
    _showSelectCountryState = widget.areaType == AreaType.country && country == null;
    super.initState();
  }

  void _nextPage() {
    if (_showSelectCountryState) return;
    _bloc.add(UserRatingFetchNext(selectedPeriod.value));
  }

  Future<void> _onRefresh() async {
    if (_showSelectCountryState) return;
    _bloc.add(UserRatingRefresh(selectedPeriod.value));
    await _bloc.stream
        .firstWhere((state) => state.status != PagingStatus.loadingFirstPage)
        .timeout(const Duration(seconds: 4), onTimeout: () => _bloc.state);
  }

  void _onPeriodChanged(PeriodType period) {
    if (_showSelectCountryState) return;
    selectedPeriod.value = period;
    _bloc.add(UserRatingRefresh(period));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: _onRefresh,
            ),
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            ValueListenableBuilder(
              valueListenable: selectedPeriod,
              builder: (context, value, child) {
                return UserRatingPeriodTypesHeader(
                  selectedPeriod: value,
                  onPeriodChanged: _onPeriodChanged,
                );
              },
            ),
            if (_showSelectCountryState)
              const SliverFillRemaining(
                child: UserRatingCountryNotSelectedWidget(),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: BlocBuilder<UserRatingBloc, UserRatingState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    return PagedSliverList<int, RatingParticipantModel>.separated(
                      state: state,
                      fetchNextPage: _nextPage,
                      separatorBuilder: (context, index) => const Divider(),
                      builderDelegate: PagedChildBuilderDelegate<RatingParticipantModel>(
                        itemBuilder: (context, item, index) {
                          return RatingParticipantCard(item);
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    selectedPeriod.dispose();
    super.dispose();
  }
}

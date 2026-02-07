import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class UserRatingTabView extends StatefulWidget {
  const UserRatingTabView({super.key});

  @override
  State<UserRatingTabView> createState() => _UserRatingTabViewState();
}

class _UserRatingTabViewState extends State<UserRatingTabView> {
  late final UserRatingBloc _bloc;
  late final ValueNotifier<PeriodType> selectedPeriod;

  @override
  void initState() {
    _bloc = context.read<UserRatingBloc>();
    selectedPeriod = ValueNotifier(PeriodType.weekly);
    super.initState();
  }

  void _nextPage() {
    _bloc.add(UserRatingFetchNext(selectedPeriod.value));
  }

  Future<void> _onRefresh() async {
    _bloc.add(UserRatingRefresh(selectedPeriod.value));
  }

  void _onPeriodChanged(PeriodType period) {
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
            BlocBuilder<UserRatingBloc, UserRatingState>(
              bloc: _bloc,
              builder: (context, state) {
                return PagedSliverList<int, RatingParticipantModel>(
                  state: state,
                  fetchNextPage: _nextPage,
                  builderDelegate: PagedChildBuilderDelegate<RatingParticipantModel>(
                    itemBuilder: (context, item, index) {
                      return ListTile(
                        title: Text(item.fullName),
                        subtitle: Text(item.ratingNumber.toString()),
                      );
                    },
                  ),
                );
              },
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

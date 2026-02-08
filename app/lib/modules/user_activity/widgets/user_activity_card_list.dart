import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart' as auth;
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityWrapWithDescriptionList extends StatelessWidget {
  const UserActivityWrapWithDescriptionList(this.groupedData, {super.key});

  final Map<DateTime, List<auth.UserActivityModel>> groupedData;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<AuthCubit>().state.currentLocale;
    return Row(
      children: [
        ...groupedData.keys.map((data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AvtivityMonthItemCard(
              data: data,
              activities: groupedData[data]!,
              languageCode: locale.languageCode,
            ),
          );
        }),
        Expanded(
          child: TextButton.icon(
            onPressed: () => context.pushNamed(
              AppRouter.userActivity,
              extra: groupedData,
            ),
            label: Text(context.l10n.activityDescription),
            iconAlignment: IconAlignment.end,
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
      ],
    );
  }
}

class UserActivityCardList extends StatefulWidget {
  const UserActivityCardList(this.groupedData, {super.key});

  final Map<DateTime, List<auth.UserActivityModel>> groupedData;

  @override
  State<UserActivityCardList> createState() => _UserActivityCardListState();
}

class _UserActivityCardListState extends State<UserActivityCardList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.read<AuthCubit>().state.currentLocale;
    return ListView.separated(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: widget.groupedData.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final data = widget.groupedData.keys.elementAt(index);
        return AvtivityMonthItemCard(
          data: data,
          activities: widget.groupedData[data]!,
          languageCode: locale.languageCode,
        );
      },
    );
  }
}

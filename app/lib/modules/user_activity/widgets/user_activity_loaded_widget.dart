import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/modules/modules.dart';

class UserActivityLoadedWidget extends StatelessWidget {
  const UserActivityLoadedWidget(
    this.groupedData, {
    this.canUseWrapList = false,
    this.canTap = false,
    this.enabledTooltip = true,
    super.key,
  });

  final Map<DateTime, List<UserActivityModel>> groupedData;
  final bool canUseWrapList;
  final bool canTap;
  final bool enabledTooltip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      width: double.infinity,
      child: Card.outlined(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: canTap
                ? () => context.pushNamed(
                    AppRouter.userActivity,
                    extra: groupedData,
                  )
                : null,
            child: showDescription
                ? UserActivityWrapWithDescriptionList(
                    groupedData,
                    enabledTooltip: enabledTooltip,
                  )
                : UserActivityCardList(
                    groupedData,
                    enabledTooltip: enabledTooltip,
                  ),
          ),
        ),
      ),
    );
  }

  bool get showDescription {
    return canUseWrapList && groupedData.length < 3;
  }
}

import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class UserRatingTabView extends StatefulWidget {
  const UserRatingTabView({super.key});

  @override
  State<UserRatingTabView> createState() => _UserRatingTabViewState();
}

class _UserRatingTabViewState extends State<UserRatingTabView> {
  late PeriodType selectedPeriod;

  @override
  void initState() {
    super.initState();
    selectedPeriod = PeriodType.weekly;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        UserRatingPeriodTypesHeader(
          selectedPeriod: selectedPeriod,
          onPeriodChanged: (period) {
            setState(() => selectedPeriod = period);
          },
        ),
      ],
    );
  }
}

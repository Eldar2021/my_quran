import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/models/auth_model.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class UserRatingMainWidget extends StatefulWidget {
  const UserRatingMainWidget(this.auth, {super.key});

  final AuthModel auth;

  @override
  State<UserRatingMainWidget> createState() => _UserRatingMainWidgetState();
}

class _UserRatingMainWidgetState extends State<UserRatingMainWidget> {
  @override
  void initState() {
    final cubit = context.read<UserRatingMainCubit>();
    if (cubit.state is UserRatingMainInitial || cubit.state is UserRatingMainError) {
      cubit.getUserRatingMain(widget.auth.key);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRatingMainCubit, UserRatingMainState>(
      builder: (context, state) {
        return switch (state) {
          UserRatingMainInitial() || UserRatingMainLoading() => const Padding(
            padding: EdgeInsets.only(top: 16),
            child: UserRatingMainLoadingWidget(),
          ),
          UserRatingMainSuccess() => Padding(
            padding: const EdgeInsets.only(top: 16),
            child: UserRatingMainSuccessWidget(
              data: state.data,
              countryFlag: widget.auth.user.countryFlag,
            ),
          ),
          UserRatingMainError() => const SizedBox.shrink(),
        };
      },
    );
  }
}

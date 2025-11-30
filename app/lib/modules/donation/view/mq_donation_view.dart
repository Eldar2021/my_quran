import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class MqDonationView extends StatelessWidget {
  const MqDonationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RemoteConfigCubit, RemoteConfigState>(
      listener: (context, state) {
        if (!state.isDonaitonEnable) Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.donate),
        ),
        body: BlocProvider(
          create: (context) => DonationCubit(
            context.read<MqHomeRepository>(),
          )..getDonation(),
          child: const _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonationCubit, DonationState>(
      builder: (context, state) {
        return switch (state) {
          DonationInitial() || DonationLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          DonationSuccess() => DonationSuccessWidget(state.data),
          DonationError() => Center(
            child: Text(state.error.toString()),
          ),
        };
      },
    );
  }
}

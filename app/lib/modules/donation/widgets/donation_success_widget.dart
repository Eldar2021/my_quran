import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/l10n/l10.dart';

class DonationSuccessWidget extends StatelessWidget {
  const DonationSuccessWidget(this.data, {super.key});

  final MqDonationPageEntity data;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final languageCode = authCubit.state.currentLocale.languageCode;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const SizedBox(height: 20),
        Text(data.getTitle(languageCode), style: prTextTheme.titleLarge),
        const SizedBox(height: 8),
        Text(data.getDescription(languageCode), style: prTextTheme.bodyMedium),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: data.requisites.length,
          itemBuilder: (BuildContext context, int index) {
            final item = data.requisites[index];
            return MqBankInfoCard(
              bankName: item.bankType,
              bankAccount: item.requisite,
              accountName: item.accountName,
              copyText: item.requisiteForCopy,
              copyLabel: context.l10n.copy,
            );
          },
        ),
      ],
    );
  }
}

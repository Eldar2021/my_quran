import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class GenderSettingView extends StatelessWidget {
  const GenderSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        key: const Key(MqKeys.settingsGenderPage),
        title: Text(context.l10n.loginPleaseSelectGender),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        children: [
          GenderCard(
            key: const Key(MqKeys.settingsGenderMale),
            Gender.male,
            isSelect: authCubit.state.user?.gender == Gender.male,
            onTap: () => context.read<AuthCubit>().setGender(Gender.male),
          ),
          GenderCard(
            key: const Key(MqKeys.settingsGenderFemale),
            Gender.female,
            isSelect: authCubit.state.user?.gender == Gender.female,
            onTap: () => context.read<AuthCubit>().setGender(Gender.female),
          ),
        ],
      ),
    );
  }
}

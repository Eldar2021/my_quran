import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

class SelectGender extends StatelessWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authCubit = context.watch<AuthCubit>();
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          context.l10n.loginPleaseSelectGender,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: colorScheme.onBackground),
        ),
        const SizedBox(height: 30),
        GenderCard(
          Gender.male,
          key: Key(MqKeys.genderName('male')),
          isSelect: authCubit.state.gender == Gender.male,
          onTap: () {
            context.read<MqAnalytic>().track(AnalyticKey.selectGender, params: {'gender': Gender.male.name});
            context.read<AuthCubit>().saveGender(Gender.male);
          },
        ),
        GenderCard(
          Gender.female,
          key: Key(MqKeys.genderName('female')),
          isSelect: authCubit.state.gender == Gender.female,
          onTap: () {
            context.read<MqAnalytic>().track(AnalyticKey.selectGender, params: {'gender': Gender.female.name});
            context.read<AuthCubit>().saveGender(Gender.female);
          },
        ),
      ],
    );
  }
}

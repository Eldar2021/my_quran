import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/src/src.dart';


class SelectGender extends StatelessWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appCubit = context.watch<AppCubit>();
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
          isSelect: appCubit.state.gender == Gender.male,
          onTap: () => context.read<AppCubit>().changeGender(Gender.male),
        ),
        GenderCard(
          Gender.female,
          key: Key(MqKeys.genderName('female')),
          isSelect: appCubit.state.gender == Gender.female,
          onTap: () => context.read<AppCubit>().changeGender(Gender.female),
        ),
      ],
    );
  }
}

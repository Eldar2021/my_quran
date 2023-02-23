import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/models/models.dart';

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
          key: const Key('login-select-gender'),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: colorScheme.onBackground),
        ),
        const SizedBox(height: 30),
        GenderCard(
          Gender.male,
          isSelect: appCubit.state.gender == Gender.male,
          onTap: () => context.read<AppCubit>().changeGender(Gender.male),
        ),
        GenderCard(
          Gender.female,
          isSelect: appCubit.state.gender == Gender.female,
          onTap: () => context.read<AppCubit>().changeGender(Gender.female),
        ),
      ],
    );
  }
}

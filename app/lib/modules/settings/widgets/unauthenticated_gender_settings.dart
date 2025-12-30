import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class UnauthenticatedGenderSettings extends StatelessWidget {
  const UnauthenticatedGenderSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.auth != null) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.pleaseSelectGender,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            GenderRedioWidget(
              key: const Key(MqKeys.settingsGenderMale),
              gender: state.appUiGender,
              title: context.l10n.male,
              onChanged: (p0) => _updateGender(Gender.male, context),
            ),
            const SizedBox(height: 8),
            GenderRedioWidget(
              key: const Key(MqKeys.settingsGenderFemale),
              gender: state.appUiGender,
              itemIsMale: false,
              title: context.l10n.female,
              onChanged: (p0) => _updateGender(Gender.female, context),
            ),
          ],
        );
      },
    );
  }

  void _updateGender(Gender gender, BuildContext context) {
    context.read<AuthCubit>().updateGender(gender);
  }
}

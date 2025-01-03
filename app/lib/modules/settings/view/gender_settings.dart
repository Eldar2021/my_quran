import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/utils/urils.dart';

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
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.exception != null) {
            AppAlert.showErrorDialog(
              context,
              errorText: state.exception.toString(),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          children: [
            GenderCard(
              key: const Key(MqKeys.settingsGenderMale),
              Gender.male,
              isSelect: authCubit.state.gender == Gender.male,
              onTap: () async {
                MqAnalytic.track(AnalyticKey.selectGender, params: {'gender': Gender.male.name});
                context.loaderOverlay.show();
                await context.read<AuthCubit>().saveGender(Gender.male);
                if (context.mounted) context.loaderOverlay.hide();
              },
            ),
            GenderCard(
              key: const Key(MqKeys.settingsGenderFemale),
              Gender.female,
              isSelect: authCubit.state.gender == Gender.female,
              onTap: () async {
                MqAnalytic.track(AnalyticKey.selectGender, params: {'gender': Gender.female.name});
                context.loaderOverlay.show();
                await context.read<AuthCubit>().saveGender(Gender.female);
                if (context.mounted) context.loaderOverlay.hide();
              },
            ),
          ],
        ),
      ),
    );
  }
}

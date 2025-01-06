import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginBody(),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Center(
          child: Text(
            context.l10n.myQuran,
            textAlign: TextAlign.center,
            style: prTextTheme.displayMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const Spacer(),
        Center(
          child: Text(
            context.l10n.customApp,
            textAlign: TextAlign.center,
            style: prTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 30),
        LanguageDropdownButtonFormField<Locale>(
          value: authCubit.state.currentLocale,
          items: AppLocalizationHelper.locales,
          onChanged: (v) async {
            final authCubit = context.read<AuthCubit>();
            await authCubit.saveLocale(
              v?.languageCode ?? 'en',
            );
          },
          itemBuilder: (value) {
            final name = AppLocalizationHelper.getName(
              value?.toLanguageTag() ?? 'en',
            );
            return DropdownMenuItem(
              value: value,
              child: Text(name),
            );
          },
        ),
        const SizedBox(height: 50),
        Text(
          context.l10n.pleaseSelectYourGender,
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.selectGenderToPersonalize,
        ),
        GenderRedioWidget(
          gender: authCubit.state.appUiGender,
          title: context.l10n.male,
          onChanged: (p0) {
            MqAnalytic.track(
              AnalyticKey.selectGender,
              params: {'gender': Gender.male.name},
            );
            context.read<AuthCubit>().saveGender(Gender.male);
          },
        ),
        GenderRedioWidget(
          gender: authCubit.state.appUiGender,
          itemIsMale: false,
          title: context.l10n.female,
          onChanged: (p0) {
            MqAnalytic.track(
              AnalyticKey.selectGender,
              params: {'gender': Gender.female.name},
            );
            context.read<AuthCubit>().saveGender(Gender.female);
          },
        ),
        const Spacer(flex: 3),
        ElevatedButton(
          onPressed: () {
            context.pushNamed(AppRouter.loginWihtSoccial);
          },
          child: Text(context.l10n.getStarted),
        ),
        SizedBox(height: AppSpacing.bottomSpace),
      ],
    );
  }
}

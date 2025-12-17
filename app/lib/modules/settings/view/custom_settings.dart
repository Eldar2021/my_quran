import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/utils/urils.dart';

class CustomAppSettingView extends StatelessWidget {
  const CustomAppSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    return ScaffoldWithBgImage(
      appBar: AppBar(
        key: const Key(MqKeys.settingsGenderLangPage),
        title: Text(context.l10n.customApp),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(context.l10n.pleaseSelectLanguage),
              const SizedBox(height: 8),
              LanguageDropdownButtonFormField<Locale>(
                value: authCubit.state.currentLocale,
                items: AppLocalizationHelper.locales,
                onChanged: (v) => _updateLanguage(v, context),
                itemBuilder: (v) {
                  final name = AppLocalizationHelper.getName(v?.toLanguageTag());
                  return DropdownMenuItem(
                    value: v,
                    child: Text(name),
                  );
                },
              ),
              const SizedBox(height: 50),
              Text(context.l10n.pleaseSelectGender),
              const SizedBox(height: 8),
              Text(
                context.l10n.selectGenderForPersonalization,
              ),
              GenderRedioWidget(
                key: const Key(MqKeys.settingsGenderMale),
                gender: authCubit.state.appUiGender,
                title: context.l10n.male,
                onChanged: (p0) => _updateGender(Gender.male, context),
              ),
              GenderRedioWidget(
                key: const Key(MqKeys.settingsGenderFemale),
                gender: authCubit.state.appUiGender,
                itemIsMale: false,
                title: context.l10n.female,
                onChanged: (p0) => _updateGender(Gender.female, context),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: Text(context.l10n.saveChanges),
              ),
              SizedBox(height: AppSpacing.bottomSpace),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateLanguage(
    Locale? locale,
    BuildContext context,
  ) async {
    final authCubit = context.read<AuthCubit>();
    context.loaderOverlay.show();
    await authCubit.updateUserData(
      UpdateLanguageParam(
        userId: authCubit.state.auth?.key ?? '',
        language: locale?.languageCode ?? 'en',
      ),
      unAuthenticatedNewState: authCubit.state.copyWith(
        localeForNow: locale?.languageCode ?? 'en',
      ),
    );
    if (context.mounted) context.loaderOverlay.hide();
  }

  Future<void> _updateGender(
    Gender gender,
    BuildContext context,
  ) async {
    MqAnalytic.track(
      AnalyticKey.selectGender,
      params: {'gender': gender.name},
    );
    final authCubit = context.read<AuthCubit>();
    context.loaderOverlay.show();
    await authCubit.updateUserData(
      UpdateGenderParam(
        userId: authCubit.state.auth?.key ?? '',
        gender: gender,
      ),
      unAuthenticatedNewState: authCubit.state.copyWith(
        genderForNow: gender,
      ),
    );
    if (context.mounted) context.loaderOverlay.hide();
  }
}

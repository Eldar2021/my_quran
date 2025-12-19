import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class CustomAppSettingView extends StatelessWidget {
  const CustomAppSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBgImage(
      appBar: AppBar(
        key: const Key(MqKeys.settingsGenderLangPage),
        title: Text(context.l10n.customApp),
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          context.manageLoader(state is ProfileLoading);
          if (state is ProfileSuccess) {
            _onSuccess(state.user, context);
          } else if (state is ProfileError) {
            _onError(state.error, context);
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
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return LanguageDropdownButtonFormField<Locale>(
                    value: state.currentLocale,
                    items: AppLocalizationHelper.locales,
                    onChanged: (v) => _updateLanguage(v, context),
                    itemBuilder: (v) {
                      final name = AppLocalizationHelper.getName(v?.toLanguageTag());
                      return DropdownMenuItem(
                        value: v,
                        child: Text(name),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 50),
              Text(context.l10n.pleaseSelectGender),
              const SizedBox(height: 8),
              Text(
                context.l10n.selectGenderForPersonalization,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return GenderRedioWidget(
                    key: const Key(MqKeys.settingsGenderMale),
                    gender: state.appUiGender,
                    title: context.l10n.male,
                    onChanged: (p0) => _updateGender(Gender.male, context),
                  );
                },
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return GenderRedioWidget(
                    key: const Key(MqKeys.settingsGenderFemale),
                    gender: state.appUiGender,
                    itemIsMale: false,
                    title: context.l10n.female,
                    onChanged: (p0) => _updateGender(Gender.female, context),
                  );
                },
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

  void _onSuccess(AuthModel model, BuildContext context) {
    context.read<AuthCubit>().updateAuth(model);
  }

  void _onError(Object error, BuildContext context) {
    AppSnackbar.showError(
      context: context,
      title: error.toString(),
    );
    final authCubit = context.read<AuthCubit>();
    final profileCubit = context.read<ProfileCubit>();
    if (authCubit.state.auth != null) {
      profileCubit.setAuth(authCubit.state.auth!);
    }
  }

  void _updateLanguage(
    Locale? locale,
    BuildContext context,
  ) {
    final authCubit = context.read<AuthCubit>();
    final profileCubit = context.read<ProfileCubit>();
    final localeCode = locale?.languageCode ?? 'en';
    if (authCubit.state.auth != null) {
      profileCubit.updateUserData(
        UpdateLanguageParam(
          language: localeCode,
          userId: authCubit.state.auth?.key ?? '',
        ),
      );
    } else {
      authCubit.uupdateLocale(localeCode);
    }
  }

  void _updateGender(
    Gender gender,
    BuildContext context,
  ) {
    final authCubit = context.read<AuthCubit>();
    final profileCubit = context.read<ProfileCubit>();
    if (authCubit.state.auth != null) {
      profileCubit.updateUserData(
        UpdateGenderParam(
          gender: gender,
          userId: authCubit.state.auth?.key ?? '',
        ),
      );
    } else {
      authCubit.updateGender(gender);
    }
  }
}

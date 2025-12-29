import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class ProfileEditLanguageView extends StatefulWidget {
  const ProfileEditLanguageView(this.locale, {super.key});

  final Locale locale;

  @override
  State<ProfileEditLanguageView> createState() => _ProfileEditLanguageViewState();
}

class _ProfileEditLanguageViewState extends State<ProfileEditLanguageView> {
  late Locale _locale;

  @override
  void initState() {
    _locale = widget.locale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: colorScheme.surface,
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  context.manageLoader(state.isLoading);
                  if (state is ProfileSuccess) {
                    _onSuccess(state.user, context);
                  } else if (state is ProfileError) {
                    _onError(state.error, context);
                  }
                },
                builder: (context, state) {
                  return RadioGroup<Locale>(
                    groupValue: _locale,
                    onChanged: (Locale? value) {
                      _updateLanguage(value, context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: AppLocalizationHelper.locales
                          .map(
                            (e) => RadioListTile<Locale>(
                              value: e,
                              title: Text(
                                AppLocalizationHelper.getName(e.languageCode.toLowerCase()),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  void _onSuccess(AuthModel auth, BuildContext context) {
    context.read<AuthCubit>().updateAuth(auth);
    Navigator.pop(context);
  }

  void _onError(Object error, BuildContext context) {
    setState(() => _locale = widget.locale);
    AppSnackbar.showError(context: context, title: error.toString());
  }

  void _updateLanguage(Locale? locale, BuildContext context) {
    if (locale == null) return;
    setState(() => _locale = locale);
    final authKey = context.read<AuthCubit>().auth?.key ?? '';
    context.read<ProfileCubit>().updateUserData(
      UpdateLanguageParam(
        userId: authKey,
        language: locale.languageCode.toUpperCase(),
      ),
    );
  }
}

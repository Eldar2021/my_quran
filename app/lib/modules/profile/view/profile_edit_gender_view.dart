import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class ProfileEditGenderView extends StatefulWidget {
  const ProfileEditGenderView(this.gender, {super.key});

  final Gender gender;

  @override
  State<ProfileEditGenderView> createState() => _ProfileEditGenderViewState();
}

class _ProfileEditGenderViewState extends State<ProfileEditGenderView> {
  late Gender _gender;

  @override
  void initState() {
    _gender = widget.gender;
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
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                context.manageLoader(state.isLoading);
                if (state is ProfileSuccess) {
                  _onSuccess(state.user, context);
                } else if (state is ProfileError) {
                  _onError(state.error, context);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    GenderRedioWidget(
                      key: const Key(MqKeys.settingsGenderMale),
                      gender: switch (_gender) {
                        Gender.male => AppUiGender.male,
                        Gender.female => AppUiGender.famela,
                      },
                      title: context.l10n.male,
                      onChanged: (p0) => _updateGender(Gender.male, context),
                    ),
                    GenderRedioWidget(
                      key: const Key(MqKeys.settingsGenderFemale),
                      gender: switch (_gender) {
                        Gender.male => AppUiGender.male,
                        Gender.female => AppUiGender.famela,
                      },
                      itemIsMale: false,
                      title: context.l10n.female,
                      onChanged: (p0) => _updateGender(Gender.female, context),
                    ),
                  ],
                );
              },
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
    AppSnackbar.showError(context: context, title: error.toString());
  }

  void _updateGender(Gender gender, BuildContext context) {
    setState(() => _gender = gender);
    final authKey = context.read<AuthCubit>().auth?.key ?? '';
    context.read<ProfileCubit>().updateUserData(
      UpdateGenderParam(userId: authKey, gender: gender),
    );
  }
}

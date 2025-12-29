import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

const _defaultAuthMode = AuthModel(key: 'key', user: UserModel());

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state.auth ?? _defaultAuthMode;
    final gender = context.watch<AuthCubit>().state.currentGender;
    final locale = context.watch<AuthCubit>().state.currentLocale;
    final user = auth.user;
    final avatarUrl = user.avatar;
    final firstName = (user.firstName ?? '').trim();
    final lastName = (user.lastName ?? '').trim();
    final userName = (user.username ?? '').trim();
    final email = (user.email ?? '').trim();
    final phoneNumber = (user.phoneNumber ?? '').trim();
    final country = (user.country ?? '').trim();
    final timeZone = (user.timezone ?? '').trim();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 12),
          UserProfileAvatarWidget(
            avatarUrl: avatarUrl,
            gender: gender,
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.firstName,
            value: firstName,
            hintText: firstName.isEmpty ? context.l10n.empty : null,
            onEdit: () => _onEdit(ProfileEditFirstNameView(firstName)),
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.lastName,
            value: lastName,
            hintText: lastName.isEmpty ? context.l10n.empty : null,
            onEdit: () => _onEdit(ProfileEditLastNameView(lastName)),
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.userName,
            value: userName,
            hintText: userName.isEmpty ? context.l10n.empty : null,
            onEdit: () => _onEdit(ProfileEditUserNameView(userName)),
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.email,
            value: email,
            hintText: email.isEmpty ? context.l10n.empty : null,
            onEdit: () => _onEdit(ProfileEditEmailView(email)),
          ),
          const SizedBox(height: 16),
          Builder(
            builder: (context) {
              String value;
              final a1 = phoneNumber.split('-');
              if (a1.length > 1) {
                value = a1[1];
              } else {
                value = phoneNumber;
              }
              return UserProfileItemField(
                title: context.l10n.phoneNumber,
                value: value,
                hintText: phoneNumber.isEmpty ? context.l10n.empty : null,
                onEdit: () => _onEdit(ProfileEditPhoneNumberView(phoneNumber)),
              );
            },
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.country,
            value: country,
            hintText: country.isEmpty ? context.l10n.empty : null,
            onEdit: () => _onEdit(ProfileEditCountryView(country)),
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.gender,
            value: switch (gender) {
              Gender.male => context.l10n.male,
              Gender.female => context.l10n.female,
            },
            onEdit: () => _onEdit(ProfileEditGenderView(gender)),
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.language,
            value: AppLocalizationHelper.getName(
              locale.languageCode.toLowerCase(),
            ),
            onEdit: () => _onEdit(ProfileEditLanguageView(locale)),
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.timeZone,
            value: timeZone,
            hintText: timeZone.isEmpty ? context.l10n.empty : null,
            onEdit: () => _onEdit(ProfileEditTimezoneView(timeZone)),
          ),
          const SizedBox(height: 30),
          const UserProfileLogoutDeleteSections(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  void _onEdit(Widget widget) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        barrierDismissible: true,
        builder: (context) => widget,
      ),
    );
  }
}

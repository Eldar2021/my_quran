import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

const _defaultAuthMode = AuthModel(key: 'key', user: UserModel());

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().auth ?? _defaultAuthMode;
    final user = auth.user;
    final avatarUrl = user.avatar;
    final gender = user.gender ?? Gender.male;
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';
    final userName = user.username ?? '';
    final email = user.email ?? '';
    final phoneNumber = user.phoneNumber ?? '';
    final country = user.country ?? '';
    final language = user.language ?? 'en';
    final timeZone = user.timezone ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
            title: 'First name',
            value: firstName,
            hintText: firstName.isEmpty ? context.l10n.empty : null,
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: 'Last name',
            value: lastName,
            hintText: lastName.isEmpty ? context.l10n.empty : null,
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: 'User name',
            value: userName,
            hintText: userName.isEmpty ? context.l10n.empty : null,
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: context.l10n.email,
            value: email,
            hintText: email.isEmpty ? context.l10n.empty : null,
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: 'Phone number',
            value: phoneNumber,
            hintText: phoneNumber.isEmpty ? context.l10n.empty : null,
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: 'Country',
            value: country,
            hintText: country.isEmpty ? context.l10n.empty : null,
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: 'Gender',
            value: switch (gender) {
              Gender.male => context.l10n.male,
              Gender.female => context.l10n.female,
            },
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: 'Language',
            value: AppLocalizationHelper.getName(language.toLowerCase()),
            onEdit: () {},
          ),
          const SizedBox(height: 16),
          UserProfileItemField(
            title: 'Time zone',
            value: timeZone,
            hintText: timeZone.isEmpty ? context.l10n.empty : null,
            onEdit: () {},
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/modules/modules.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colors.surfaceContainerLow,
        title: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final auth = state.auth;
            final fullName = (auth?.user.fullName ?? '').trim();
            if (fullName.isNotEmpty) return Text(fullName);
            return const Text(ApiConst.appName);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final auth = state.auth;
              final gender = state.currentGender;
              if (auth != null) {
                return UserProfileAuthenticatedCard(
                  auth: auth,
                  onTap: () => _navigateToProfile(context),
                );
              }
              return UserProfileUnauthenticatedCard(
                gender: gender,
                onTap: () => _navigateToLogin(context),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final auth = state.auth;
              return MoreServices(
                enableCreateHatims: auth?.user.canCreateHatim ?? false,
                enableJoinHatims: auth != null,
              );
            },
          ),
          const SizedBox(height: 16),
          const MoreActions(),
          const SizedBox(height: 16),
          const MyQuranAppVersionTile(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    context.pushNamed(AppRouter.profile);
  }

  void _navigateToLogin(BuildContext context) {
    context.pushNamed(AppRouter.loginWihtSoccial);
  }
}

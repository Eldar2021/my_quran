import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
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
      body: RefreshIndicator.adaptive(
        onRefresh: () => _refresh(context),
        child: ListView(
          key: const Key(MqKeys.moreListView),
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final auth = state.auth;
                  final gender = state.currentGender;
                  if (auth != null) {
                    return UserProfileAuthenticatedCard(
                      auth: auth,
                      unfieldsCount: auth.user.unfieldsCount,
                      onTap: () => _navigateToProfile(context),
                    );
                  }
                  return UserProfileUnauthenticatedCard(
                    gender: gender,
                    onTap: () => _navigateToLogin(context),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final auth = state.auth;
                  if (auth != null) {
                    return UserRatingMainWidget(auth);
                  }
                  return const SizedBox.shrink();
                },
              ),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: MoreActions(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: MyQuranAppVersionTile(
                key: Key(MqKeys.moreAppVersionTile),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    final auth = context.read<AuthCubit>().state.auth;
    if (auth != null) {
      await context.read<UserRatingMainCubit>().refresh(auth.key);
    }
  }

  void _navigateToProfile(BuildContext context) {
    context.pushNamed(AppRouter.profile);
  }

  void _navigateToLogin(BuildContext context) {
    context.pushNamed(AppRouter.loginWihtSoccial);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class UserProfileLogoutDeleteSections extends StatelessWidget {
  const UserProfileLogoutDeleteSections({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final auth = state.auth;
        if (auth == null) return const SizedBox.shrink();
        return Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: colorScheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DrawerTile(
                key: const Key(MqKeys.logoutButton),
                title: context.l10n.logout,
                icon: Assets.icons.logout.svg(
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                onTap: () => _onLogout(context),
              ),
              DrawerTile(
                title: context.l10n.deleteAccount,
                icon: Assets.icons.trash.svg(
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                onTap: () => _onDeleteAccount(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLogout(BuildContext context) {
    MqBottomSheets.showConfirmSheet<void>(
      context: context,
      title: context.l10n.logout,
      content: context.l10n.confirmLogout,
      cancelText: context.l10n.cancel,
      onCancel: () => Navigator.pop(context),
      confirmButton: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLogout) {
            _clearAuthStateAndGoLogin(context);
          } else if (state is ProfileError) {
            _onError(context);
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            key: const Key(MqKeys.confirmLogoutButtonYes),
            onPressed: () {
              context.read<ProfileCubit>().logout();
            },
            child: switch (state) {
              ProfileLoading(:final type) =>
                type == ProfileLoadingType.logout
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    : Text(context.l10n.yes),
              _ => Text(context.l10n.yes),
            },
          );
        },
      ),
    );
  }

  void _onDeleteAccount(BuildContext context) {
    MqBottomSheets.showConfirmSheet<void>(
      context: context,
      title: context.l10n.deleteAccount,
      content: context.l10n.confirmDeleteAccount,
      cancelText: context.l10n.cancel,
      onCancel: () => Navigator.pop(context),
      confirmButton: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileDeleted) {
            _clearAuthStateAndGoLogin(context);
          } else if (state is ProfileError) {
            _onError(context);
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            key: const Key(MqKeys.deleteAccountButton),
            onPressed: () {
              context.read<ProfileCubit>().deleteAccount();
            },
            child: switch (state) {
              ProfileLoading(:final type) =>
                type == ProfileLoadingType.deleteAccount
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    : Text(context.l10n.yes),
              _ => Text(context.l10n.yes),
            },
          );
        },
      ),
    );
  }

  void _clearAuthStateAndGoLogin(BuildContext context) {
    context.read<AuthCubit>().clearAuth();
    context.go('/login');
  }

  void _onError(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final profileCubit = context.read<ProfileCubit>();
    if (authCubit.state.auth != null) {
      profileCubit.setAuth(authCubit.state.auth!);
    }
    AppSnackbar.showError(
      context: context,
      title: context.l10n.error,
    );
  }
}

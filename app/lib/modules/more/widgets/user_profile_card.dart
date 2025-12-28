import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';

class UserProfileAuthenticatedCard extends StatelessWidget {
  const UserProfileAuthenticatedCard({
    required this.auth,
    this.onTap,
    super.key,
  });

  final AuthModel auth;
  final VoidCallback? onTap;

  static const _avatarRadius = 28.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final avatarUrl = auth.user.avatar;
    final gender = auth.user.gender ?? Gender.male;
    final fullName = (auth.user.fullName ?? '').trim();
    final email = (auth.user.email ?? '').trim();
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        onTap: onTap,
        title: Text(
          fullName.isNotEmpty ? fullName : context.l10n.hello,
        ),
        subtitle: email.isNotEmpty ? Text(auth.user.email ?? '') : null,
        trailing: const Icon(Icons.arrow_forward_ios),
        leading: CircleAvatar(
          radius: _avatarRadius,
          backgroundColor: colorScheme.surfaceContainerLow,
          child: avatarUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(_avatarRadius),
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl,
                    fit: BoxFit.cover,
                    width: _avatarRadius * 2,
                    height: _avatarRadius * 2,
                    errorWidget: (context, url, error) {
                      return switch (gender) {
                        Gender.male => Assets.icons.userMale.svg(
                          colorFilter: ColorFilter.mode(
                            colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gender.female => Assets.icons.userFemale.svg(
                          colorFilter: ColorFilter.mode(
                            colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                      };
                    },
                  ),
                )
              : switch (gender) {
                  Gender.male => Assets.icons.userMale.svg(
                    colorFilter: ColorFilter.mode(
                      colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                  Gender.female => Assets.icons.userFemale.svg(
                    colorFilter: ColorFilter.mode(
                      colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                },
        ),
      ),
    );
  }
}

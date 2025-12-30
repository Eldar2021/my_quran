import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

class UserProfileAvatarWidget extends StatelessWidget {
  const UserProfileAvatarWidget({
    required this.avatarUrl,
    required this.gender,
    super.key,
  });

  static const _avatarRadius = 50.0;
  final String? avatarUrl;
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: _avatarRadius,
      backgroundColor: colorScheme.surfaceContainerLow,
      child: avatarUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(_avatarRadius),
              child: CachedNetworkImage(
                imageUrl: avatarUrl!,
                fit: BoxFit.cover,
                width: _avatarRadius * 2,
                height: _avatarRadius * 2,
                errorWidget: (context, url, error) {
                  return switch (gender) {
                    Gender.male => Assets.icons.userMale.svg(
                      height: _avatarRadius,
                      colorFilter: ColorFilter.mode(
                        colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                    Gender.female => Assets.icons.userFemale.svg(
                      height: _avatarRadius,
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
                height: _avatarRadius,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              Gender.female => Assets.icons.userFemale.svg(
                height: _avatarRadius,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            },
    );
  }
}

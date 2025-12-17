import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final userName = state.auth?.user.firstName ?? context.l10n.hello;
        final userGender = state.auth?.user.gender ?? state.genderForNow;
        return ListTile(
          title: Text(userName, maxLines: 1),
          leading: CircleAvatar(
            backgroundColor: colorScheme.onSurface.withValues(alpha: 0.1),
            child: userGender == Gender.female
                ? Assets.icons.userFemale.svg(
                    colorFilter: ColorFilter.mode(
                      colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  )
                : Assets.icons.userMale.svg(
                    colorFilter: ColorFilter.mode(
                      colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

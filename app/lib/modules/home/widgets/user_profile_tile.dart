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
    final authCubit = context.watch<AuthCubit>();
    final user = authCubit.state.user;
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      title: Text(
        user?.username ?? context.l10n.hello,
        maxLines: 1,
      ),
      leading: CircleAvatar(
        backgroundColor: colorScheme.onSurface.withOpacity(0.1),
        child: user?.gender == Gender.male
            ? Assets.icons.userMale.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              )
            : Assets.icons.userFemale.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}

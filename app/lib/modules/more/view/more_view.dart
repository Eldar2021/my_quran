import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
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
            if (auth != null) {
              return Text(auth.user.fullName ?? context.l10n.myQuran);
            }
            return Text(context.l10n.myQuran);
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
                  onTap: () {},
                );
              }
              return UserProfileUnauthenticatedCard(
                gender: gender,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}

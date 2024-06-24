import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_quran/app/app.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/theme/theme.dart';
import 'package:my_quran/utils/urils.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final isIntegrationTest = const AppConfig().isIntegrationTest;
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.user != null) {
            context.read<AuthCubit>().setUserData(state.user!);
            context.goNamed(AppRouter.home);
          } else if (state.exception != null) {
            AppAlert.showErrorDialog(
              context,
              errorText: state.exception.toString(),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Assets.images.splash.image(),
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.welcome,
              style: context.titleLarge!.copyWith(color: context.colors.primary, fontSize: 50),
            ),
            const SizedBox(height: 30),
            CustomButtonWithIcon(
              icon: const Icon(FontAwesomeIcons.google),
              onPressed: () async {
                unawaited(AppAlert.showLoading(context));
                if (isIntegrationTest) {
                  try {
                    await FirebaseAuth.instance.signInWithCustomToken('932f9a2fc49147fdcd571521d49852e7233f0046');
                    // ignore: use_build_context_synchronously
                    context.goNamed(AppRouter.home);
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    AppAlert.showErrorDialog(context, errorText: e.toString());
                  }
                } else {
                  await context.read<AuthCubit>().signInWithGoogle();
                  if (context.mounted) context.loaderOverlay.hide();
                }
              },
              text: context.l10n.google,
            ),
            const SizedBox(height: 30),
            Text(
              context.l10n.orSignInWith,
              textAlign: TextAlign.center,
              style: context.bodyLarge!.copyWith(color: context.colors.shadow, fontSize: 17),
            ),
            const SizedBox(height: 33),
            CustomButtonWithIcon(
              icon: const Icon(FontAwesomeIcons.apple),
              onPressed: () async {
                unawaited(AppAlert.showLoading(context));
                if (isIntegrationTest) {
                  try {
                    await FirebaseAuth.instance.signInWithCustomToken('932f9a2fc49147fdcd571521d49852e7233f0046');
                    // ignore: use_build_context_synchronously
                    context.goNamed(AppRouter.home);
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    AppAlert.showErrorDialog(context, errorText: e.toString());
                  }
                } else {
                  await context.read<AuthCubit>().signInWithApple();
                  if (context.mounted) context.loaderOverlay.hide();
                }
              },
              text: context.l10n.apple,
            ),
            const Spacer(),
            TextButton(
              onPressed: () => AppLaunch.launchURL(apiConst.provicyPolicy),
              child: Text(
                context.l10n.privacyPolicy,
                style: context.bodyLarge!.copyWith(
                  color: context.colors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

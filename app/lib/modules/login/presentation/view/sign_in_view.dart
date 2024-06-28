import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';

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
    return Scaffold(
      key: const Key(MqKeys.signInView),
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
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              child: Assets.images.splash.image(),
            ),
            const SizedBox(height: 32),
            Text(
              '${context.l10n.welcome}!',
              style: context.titleLarge!.copyWith(color: context.colors.primary, fontSize: 30),
            ),
            const SizedBox(height: 33),
            const Spacer(),
            Text(
              context.l10n.orSignInWith,
              textAlign: TextAlign.center,
              style: context.bodyLarge!.copyWith(color: context.colors.shadow, fontSize: 17),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                key: Key(MqKeys.loginTypeName('google')),
                onPressed: () async {
                  unawaited(AppAlert.showLoading(context));
                  await context.read<AuthCubit>().signInWithGoogle();
                  if (context.mounted) context.loaderOverlay.hide();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.googleIcon.svg(height: 25),
                    const SizedBox(width: 10),
                    Text(context.l10n.google, style: context.bodyMedium),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 30),
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: SignInWithAppleButton(
            //     key: Key(MqKeys.loginTypeName('apple')),
            //     onPressed: () async {
            //       if (Theme.of(context).platform == TargetPlatform.android) {
            //         AppSnackbar.showSnackbar(context, context.l10n.appleSignInNotAvailable);
            //       } else {
            //         unawaited(AppAlert.showLoading(context));
            //         await context.read<AuthCubit>().signInWithApple();
            //         if (context.mounted) context.loaderOverlay.hide();
            //       }
            //     },
            //     text: context.l10n.apple,
            //   ),
            // ),
            // const Spacer(),
            const SizedBox(height: 30),
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

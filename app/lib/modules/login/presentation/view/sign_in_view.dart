import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
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
    final emailController = TextEditingController();
    final forgotPasswordEmailController = TextEditingController();
    final passwordController = TextEditingController();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
                //   child: Assets.images.splash.image(),
                // ),
                // const SizedBox(height: 32),
                Align(
                  child: Text(
                    '${context.l10n.welcome}!',
                    style: context.titleLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.email,
                  textAlign: TextAlign.center,
                  style: context.bodyMedium!.copyWith(color: context.colors.secondary),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: context.l10n.email,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.password,
                  textAlign: TextAlign.center,
                  style: context.bodyMedium!.copyWith(color: context.colors.secondary),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: context.l10n.password,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<AuthCubit>().togglePasswordVisibility();
                      },
                      icon: Icon(
                        context.watch<AuthCubit>().passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  obscureText: !context.watch<AuthCubit>().passwordVisible,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // ignore: inference_failure_on_function_invocation
                      AppBottomSheet.showBottomSheet(
                        context,
                        initialChildSize: 0.4,
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                context.l10n.email,
                                textAlign: TextAlign.center,
                                style: context.bodyMedium!.copyWith(color: context.colors.secondary),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: forgotPasswordEmailController,
                                decoration: InputDecoration(
                                  labelText: context.l10n.email,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  MqAnalytic.track(AnalyticKey.tapForgotPassword);
                                  context.read<AuthCubit>().forgotPassword(forgotPasswordEmailController.text);
                                  // AppAlert.showInfoDialog(
                                  //   context,
                                  //   title: context.l10n.passwordReset,
                                  //   content: context.l10n.passwordResetInstructions,
                                  // );
                                  Navigator.pop(context);
                                },
                                child: Text(context.l10n.forgotPassword),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      context.l10n.forgotPassword,
                      style: context.labelMedium!.copyWith(color: context.colors.error),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  key: Key(MqKeys.loginTypeName('email')),
                  text: context.l10n.signIn,
                  onPressed: () async {
                    MqAnalytic.track(
                      AnalyticKey.tapLoginWithSoccial,
                      params: {'soccial': 'email'},
                    );
                    unawaited(AppAlert.showLoading(context));
                    await context.read<AuthCubit>().signInWithEmail(
                          emailController.text,
                          passwordController.text,
                        );
                    if (context.mounted) context.loaderOverlay.hide();
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        context.l10n.orContinueWith,
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  key: Key(MqKeys.loginTypeName('google')),
                  onTap: () async {
                    MqAnalytic.track(
                      AnalyticKey.tapLoginWithSoccial,
                      params: {'soccial': 'google'},
                    );
                    unawaited(AppAlert.showLoading(context));
                    await context.read<AuthCubit>().signInWithGoogle();
                    if (context.mounted) context.loaderOverlay.hide();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black26),
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
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.l10n.dontHaveAccount),
                    TextButton(
                      onPressed: () {
                        MqAnalytic.track(AnalyticKey.goRegister);
                        context.goNamed(AppRouter.register);
                      },
                      child: Text(context.l10n.signUp),
                    ),
                  ],
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
                const SizedBox(height: 40),
                Align(
                  child: TextButton(
                    onPressed: () {
                      MqAnalytic.track(AnalyticKey.tapPrivacyPolicy);
                      AppLaunch.launchURL(apiConst.provicyPolicy);
                    },
                    child: Text(
                      context.l10n.privacyPolicy,
                      style: context.bodyLarge!.copyWith(
                        // color: context.colors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

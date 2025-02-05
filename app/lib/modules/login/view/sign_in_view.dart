import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/api/api_const.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/utils/urils.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);
    return ScaffoldWithBgImage(
      key: const Key(MqKeys.signInView),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.goNamed(AppRouter.login);
          },
        ),
      ),
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
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Text(
                  context.l10n.myQuran,
                  textAlign: TextAlign.center,
                  style: prTextTheme.displayMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.07),
              TextFormField(
                key: const Key(MqKeys.emailTextField),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.enterEmail;
                  }
                  if (!AppRegExp.email.hasMatch(value)) {
                    return context.l10n.enterEmail;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: context.l10n.enterEmail,
                  prefixIcon: const Icon(Icons.email, size: 28),
                  hintText: context.l10n.enterEmail,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                key: const Key(MqKeys.sendOtp),
                child: Text(context.l10n.login),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    MqAnalytic.track(AnalyticKey.goVerificationOtp);
                    try {
                      unawaited(AppAlert.showLoading(context));
                      context.read<AuthCubit>().loginWithEmail(emailController.text);
                      context.goNamed(
                        AppRouter.verificationCode,
                        pathParameters: {'email': emailController.text},
                      );
                      if (context.mounted) context.loaderOverlay.hide();
                    } catch (e) {
                      log(e.toString());
                    }
                  }
                },
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(context.l10n.orContinueWith),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              GoogleSignInButton(
                key: Key(MqKeys.loginTypeName('google')),
                label: context.l10n.continueWithGoogle,
                onPressed: () async {
                  MqAnalytic.track(
                    AnalyticKey.tapLogin,
                    params: {'soccial': 'google'},
                  );
                  unawaited(AppAlert.showLoading(context));
                  await context.read<AuthCubit>().signInWithGoogle();
                  if (context.mounted) context.loaderOverlay.hide();
                },
              ),
              const SizedBox(height: 14),
              if (Platform.isIOS)
                AppleSignInButton(
                  key: Key(MqKeys.loginTypeName('apple')),
                  label: context.l10n.continueWithApple,
                  onPressed: () async {
                    MqAnalytic.track(
                      AnalyticKey.tapLogin,
                      params: {'soccial': 'apple'},
                    );
                    unawaited(AppAlert.showLoading(context));
                    await context.read<AuthCubit>().signInWithApple();
                    if (context.mounted) context.loaderOverlay.hide();
                  },
                ),
              SizedBox(height: size.height * 0.04),
              LinkTextButton(
                text: context.l10n.privacyPolicy,
                onPressed: () {
                  MqAnalytic.track(AnalyticKey.tapPrivacyPolicy);
                  AppLaunch.launchURL(ApiConst.provicyPolicy);
                },
              ),
              SizedBox(height: size.height * 0.04),
              TextButton(
                onPressed: () {
                  context.goNamed(AppRouter.home);
                },
                child: Text(
                  context.l10n.continueAsGuest,
                  style: prTextTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

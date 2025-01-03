import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_theme/mq_app_theme.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 100),
              Align(
                child: Text(
                  '${context.l10n.welcome}!',
                  style: context.titleLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                child: Text(context.l10n.enterEmailToLogin),
              ),
              const SizedBox(height: 40),
              Text(
                context.l10n.email,
                style: context.bodyMedium!.copyWith(color: context.colors.secondary),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                key: const Key(MqKeys.emailTextField),
                controller: emailController,
                labelText: context.l10n.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.emailRequired;
                  }
                  if (!AppRegExp.email.hasMatch(value)) {
                    return context.l10n.invalidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              CustomButton(
                key: const Key(MqKeys.sendOtp),
                text: context.l10n.signIn,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    MqAnalytic.track(AnalyticKey.goVerificationOtp);
                    try {
                      unawaited(AppAlert.showLoading(context));
                      context.read<AuthCubit>().loginWithEmail(emailController.text);
                      context.goNamed(AppRouter.verificationCode, pathParameters: {'email': emailController.text});
                      if (context.mounted) context.loaderOverlay.hide();
                    } catch (e) {
                      log(e.toString());
                    }
                  }
                },
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 16),
              GestureDetector(
                key: Key(MqKeys.loginTypeName('google')),
                onTap: () async {
                  MqAnalytic.track(
                    AnalyticKey.tapLogin,
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
                      Text(context.l10n.google, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (Platform.isIOS)
                SignInWithAppleButton(
                  key: Key(MqKeys.loginTypeName('apple')),
                  text: 'Apple',
                  height: 50,
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
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  MqAnalytic.track(AnalyticKey.tapPrivacyPolicy);
                  AppLaunch.launchURL(apiConst.provicyPolicy);
                },
                child: Text(
                  context.l10n.privacyPolicy,
                  style: context.bodyLarge!.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.goNamed(AppRouter.home);
                },
                child: Text(context.l10n.continueAsGuest),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

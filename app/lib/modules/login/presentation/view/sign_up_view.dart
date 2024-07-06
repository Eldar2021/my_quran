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

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(MqKeys.registerView),
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
                  context.l10n.signUp,
                  textAlign: TextAlign.center,
                  style: context.titleLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                context.l10n.username,
                style: context.bodyMedium!.copyWith(color: context.colors.secondary),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: usernameController,
                labelText: context.l10n.username,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.usernameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Text(
                context.l10n.email,
                style: context.bodyMedium!.copyWith(color: context.colors.secondary),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
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
              const SizedBox(height: 25),
              Text(
                context.l10n.password,
                style: context.bodyMedium!.copyWith(color: context.colors.secondary),
              ),
              const SizedBox(height: 8),
              PasswordFormFiled(controller: passwordController),
              const SizedBox(height: 25),
              Text(
                context.l10n.confirmPassword,
                style: context.bodyMedium!.copyWith(color: context.colors.secondary),
              ),
              const SizedBox(height: 8),
              PasswordFormFiled(
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.passwordRequired;
                  }
                  if (!AppRegExp.password.hasMatch(value)) {
                    return context.l10n.passwordInvalid;
                  }
                  if (passwordController.text != confirmPasswordController.text) {
                    return context.l10n.passwordMismatchError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              CustomButton(
                key: Key(MqKeys.registerTypeName('email')),
                text: context.l10n.signUp,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    MqAnalytic.track(
                      AnalyticKey.tapSignUp,
                      params: {'method': 'email'},
                    );
                    unawaited(AppAlert.showLoading(context));
                    await context.read<AuthCubit>().signUpWithEmail(
                          email: emailController.text,
                          password: passwordController.text,
                          username: usernameController.text,
                        );
                    if (context.mounted) context.loaderOverlay.hide();
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
                      Text(context.l10n.google, style: context.bodyMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.l10n.alreadyHaveAccount),
                  TextButton(
                    onPressed: () => context.goNamed(AppRouter.loginWihtSoccial),
                    child: Text(context.l10n.signIn),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/api/api_const.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with NotificationMixin {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);
    return ScaffoldWithBgImage(
      key: const Key(MqKeys.signInView),
      appBar: AppBar(),
      body: BlocListener<LoginCubit, LoginState>(
        listener: _loginListener,
        child: Form(
          key: _formKey,
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
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validators.email(value, context),
                decoration: InputDecoration(
                  labelText: context.l10n.enterEmail,
                  prefixIcon: const Icon(Icons.email, size: 28),
                  hintText: context.l10n.enterEmail,
                ),
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder(
                valueListenable: _emailController,
                builder: (context, value, child) {
                  final isValid = _formKey.currentState!.validate();
                  return ElevatedButton(
                    key: const Key(MqKeys.sendOtp),
                    onPressed: isValid ? _sendOtp : null,
                    child: Text(context.l10n.login),
                  );
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
                onPressed: () => _signIn(true),
              ),
              const SizedBox(height: 14),
              if (Platform.isIOS)
                AppleSignInButton(
                  key: Key(MqKeys.loginTypeName('apple')),
                  label: context.l10n.continueWithApple,
                  onPressed: () => _signIn(false),
                ),
              SizedBox(height: size.height * 0.04),
              LinkTextButton(
                text: context.l10n.privacyPolicy,
                onPressed: _onPrivacyPolicy,
              ),
              SizedBox(height: size.height * 0.04),
              TextButton(
                onPressed: _onContinueAsGuest,
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

  void _loginListener(BuildContext context, LoginState state) {
    context.manageLoader(state is LoginLoading);
    if (state is LoginSuccess) {
      _onLoginSuccess(state.data);
    } else if (state is LoginError) {
      _onLoginError(state.error);
    }
  }

  void _signIn(bool isGoogle) {
    MqAnalytic.track(
      AnalyticKey.tapLogin,
      params: {'soccial': isGoogle ? 'google' : 'apple'},
    );
    final authState = context.read<AuthCubit>().state;
    if (isGoogle) {
      context.read<LoginCubit>().signInWithGoogle(
        languageCode: authState.currentLocale.languageCode,
        gender: authState.gender,
      );
    } else {
      context.read<LoginCubit>().signInWithApple(
        languageCode: authState.currentLocale.languageCode,
        gender: authState.gender,
      );
    }
  }

  Future<void> _sendOtp() async {
    MqAnalytic.track(AnalyticKey.goVerificationOtp);
    final email = _emailController.text.trim();
    await context.read<LoginCubit>().loginWithEmail(email);
    if (mounted) {
      context.goNamed(
        AppRouter.verificationCode,
        pathParameters: {'email': email},
      );
    }
  }

  Future<void> _onLoginSuccess(AuthModel auth) async {
    await Future.wait<void>([
      context.read<AuthCubit>().setUserData(auth),
      initializeNotification(auth, context),
    ]);
    if (mounted) context.goNamed(AppRouter.home);
  }

  void _onLoginError(Object error) {
    AppAlert.showErrorDialog(
      context,
      errorText: error.toString(),
    );
  }

  void _onContinueAsGuest() {
    context.goNamed(AppRouter.home);
  }

  void _onPrivacyPolicy() {
    MqAnalytic.track(AnalyticKey.tapPrivacyPolicy);
    AppLaunch.launchURL(ApiConst.provicyPolicy);
  }
}

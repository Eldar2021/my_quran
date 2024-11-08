import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';

import 'package:my_quran/config/config.dart';
import 'package:my_quran/constants/contants.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/theme/theme.dart';
import 'package:my_quran/utils/urils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
            final exc = state.exception;
            if (exc is AppleSignInExc) {
              Navigator.canPop(context);
              showAppleDialog(exc);
            } else {
              AppAlert.showErrorDialog(
                context,
                errorText: state.exception.toString(),
              );
            }
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
                    MqAnalytic.track(
                      AnalyticKey.goVerificationOtp,
                    );
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
            ],
          ),
        ),
      ),
    );
  }

  void showAppleDialog(AppleSignInExc exc) {
    final appleData = exc.authorizationCredentialAppleID;
    final firebaseData = exc.userCredential?.credential;
    final myquranExc = exc.exc;
    AppBottomSheet.showBottomSheet<void>(
      context,
      initialChildSize: 0.9,
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('App Sign Error'),
            _DataView(
              context: context,
              appleData: appleData,
              firebaseData: firebaseData,
              myquranExc: myquranExc,
            ),
            CupertinoButton(
              onPressed: () => context.pop(),
              child: Text(context.l10n.cancel),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataView extends StatelessWidget {
  const _DataView({
    required this.context,
    required this.appleData,
    required this.firebaseData,
    required this.myquranExc,
  });

  final BuildContext context;
  final AuthorizationCredentialAppleID? appleData;
  final AuthCredential? firebaseData;
  final MqRemoteException? myquranExc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Text('Apple account data'),
          const SizedBox(height: 20),
          SelectableText('email:\n${appleData?.email}'),
          const SizedBox(height: 20),
          SelectableText('familyName:\n${appleData?.familyName}'),
          const SizedBox(height: 20),
          SelectableText('givenName:\n${appleData?.givenName}'),
          const SizedBox(height: 20),
          SelectableText('identityToken:\n${appleData?.identityToken}'),
          const SizedBox(height: 20),
          SelectableText('authorizationCode:\n${appleData?.authorizationCode}'),
          const SizedBox(height: 20),
          SelectableText('userIdentifier:\n${appleData?.userIdentifier}'),
          const SizedBox(height: 20),
          SelectableText('state:\n${appleData?.state}'),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const Text('Firebase account data'),
          const SizedBox(height: 20),
          SelectableText('accessToken:\n${firebaseData?.accessToken}'),
          const SizedBox(height: 20),
          SelectableText('providerId:\n${firebaseData?.providerId}'),
          const SizedBox(height: 20),
          SelectableText('signInMethod:\n${firebaseData?.signInMethod}'),
          const SizedBox(height: 20),
          SelectableText('token:\n${firebaseData?.token}'),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          const Text('MqRemoteException'),
          const SizedBox(height: 20),
          SelectableText('statusCode:\n${myquranExc?.statusCode}'),
          const SizedBox(height: 20),
          SelectableText('message:\n${myquranExc?.message}'),
          const SizedBox(height: 20),
          SelectableText('failureType.message:\n${myquranExc?.failureType.message}'),
          const SizedBox(height: 20),
          SelectableText('failureType.name:\n${myquranExc?.failureType.name}'),
          const SizedBox(height: 20),
          SelectableText('error:\n${myquranExc?.error}'),
          const SizedBox(height: 20),
          SelectableText('stackTrace:\n${myquranExc?.stackTrace}'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

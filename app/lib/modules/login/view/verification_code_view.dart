import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class VerificationCodeView extends StatefulWidget {
  const VerificationCodeView({required this.email, super.key});

  final String email;

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> with NotificationMixin {
  late TextEditingController verificationCodeController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    verificationCodeController = TextEditingController();
  }

  @override
  void dispose() {
    verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ScaffoldWithBgImage(
      key: const Key(MqKeys.verifyOtpView),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.goNamed(AppRouter.loginWihtSoccial);
          },
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.user != null) {
            _onLoginSuccess(state.user!);
          } else if (state.exception != null) {
            AppAlert.showErrorDialog(
              context,
              errorText: state.exception.toString(),
            );
          }
        },
        child: Form(
          key: formKey,
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
              const SizedBox(height: 60),
              Center(
                child: Text(
                  context.l10n.verification,
                  style: prTextTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.l10n.enter4DigitCode,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
              PinputWidget(
                key: const Key(MqKeys.otpTextField),
                controller: verificationCodeController,
                validator: (value) {
                  if (value == null || value.length < 4) {
                    return context.l10n.enterVerificationCode;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                key: Key(MqKeys.loginTypeName('email')),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    MqAnalytic.track(
                      AnalyticKey.tapLogin,
                      params: {'soccial': 'email'},
                    );
                    context.read<AuthCubit>().verifyOtp(
                      verificationCodeController.text,
                      widget.email,
                    );
                  }
                },
                child: Text(context.l10n.login),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onLoginSuccess(UserModelResponse user) async {
    await Future.wait<void>([
      context.read<AuthCubit>().setUserData(user),
      initializeNotification(user, context),
    ]);
    if (mounted) context.goNamed(AppRouter.home);
  }
}

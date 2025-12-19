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
  const VerificationCodeView({
    required this.email,
    super.key,
  });

  final String email;

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> with NotificationMixin {
  late final TextEditingController _controller;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _controller.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ScaffoldWithBgImage(
      key: const Key(MqKeys.verifyOtpView),
      appBar: AppBar(),
      body: BlocListener<LoginCubit, LoginState>(
        listener: _loginListener,
        child: Form(
          key: _formKey,
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
                controller: _controller,
                validator: (v) => Validators.otpValidator(v, context),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                key: Key(MqKeys.loginTypeName('email')),
                onPressed: _verify,
                child: Text(context.l10n.login),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verify() {
    if (_formKey.currentState!.validate()) {
      MqAnalytic.track(
        AnalyticKey.tapLogin,
        params: {'soccial': 'email'},
      );
      final authState = context.read<AuthCubit>().state;
      final otp = _controller.text.trim();
      context.read<LoginCubit>().verifyOtp(
        email: widget.email,
        otp: otp,
        languageCode: authState.currentLocale.languageCode,
        gender: authState.currentGender,
      );
    }
  }

  void _loginListener(BuildContext context, LoginState state) {
    context.manageLoader(state is LoginLoading);
    if (state is LoginSuccess) {
      _onLoginSuccess(state.data);
    } else if (state is LoginError) {
      _onLoginError(state.error);
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
}

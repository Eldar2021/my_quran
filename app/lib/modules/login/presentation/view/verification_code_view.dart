import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/presentation/presenation.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/config/config.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/theme/custom/typography/typography_theme.dart';
import 'package:my_quran/utils/urils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeView extends StatefulWidget {
  const VerificationCodeView({required this.email, super.key});

  final String email;

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView> {
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
    return Scaffold(
      key: const Key(MqKeys.verifyOtpView),
      appBar: AppBar(
        title: const Text('Enter a verification Code'),
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () {
            context.goNamed(AppRouter.loginWihtSoccial);
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please enter the 4-digit code sent to your email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: PinCodeTextField(
                    autoDisposeControllers: false,
                    key: const Key(MqKeys.otpTextField),
                    appContext: context,
                    length: 4,
                    controller: verificationCodeController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      inactiveColor: Colors.blue,
                      selectedColor: Colors.green,
                      errorBorderColor: context.colors.error,
                    ),
                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return 'Please enter the full verification code.';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  key: Key(MqKeys.loginTypeName('email')),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      MqAnalytic.track(
                        AnalyticKey.tapLogin,
                        params: {'soccial': 'email'},
                      );
                      context.read<AuthCubit>().verifyOtp(verificationCodeController.text, widget.email);
                    }
                  },
                  text: 'Verify',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

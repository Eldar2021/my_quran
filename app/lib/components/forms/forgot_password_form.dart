import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/theme/theme.dart';
import 'package:my_quran/utils/urils.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    required this.forgotPasswordEmailController,
    super.key,
  });
  final TextEditingController forgotPasswordEmailController;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
            CustomTextFormField(
              controller: forgotPasswordEmailController,
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  MqAnalytic.track(AnalyticKey.tapForgotPassword);
                  context.read<AuthCubit>().forgotPassword(forgotPasswordEmailController.text);
                  Navigator.pop(context);
                }
              },
              child: Text(context.l10n.resetPassword),
            ),
          ],
        ),
      ),
    );
  }
}

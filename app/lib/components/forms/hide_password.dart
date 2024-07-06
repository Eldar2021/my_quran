import 'package:flutter/material.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/utils/urils.dart';

class HidePasswordForm extends StatefulWidget {
  const HidePasswordForm({
    required this.passwordController,
    this.validator,
    super.key,
  });
  final TextEditingController passwordController;
  final FormFieldValidator<String>? validator;

  @override
  State<HidePasswordForm> createState() => _HidePasswordFormState();
}

class _HidePasswordFormState extends State<HidePasswordForm> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.passwordController,
      labelText: context.l10n.password,
      obscureText: isPasswordHidden,
      suffixIcon: IconButton(
        icon: Icon(isPasswordHidden ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            isPasswordHidden = !isPasswordHidden;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.l10n.passwordRequired;
        }
        if (!AppRegExp.password.hasMatch(value)) {
          return context.l10n.passwordInvalid;
        }
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
    );
  }
}

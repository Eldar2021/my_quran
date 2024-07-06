import 'package:flutter/material.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/utils/urils.dart';

class PasswordFormFiled extends StatefulWidget {
  const PasswordFormFiled({
    this.controller,
    this.validator,
    super.key,
  });
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordFormFiled> createState() => _PasswordFormFiledState();
}

class _PasswordFormFiledState extends State<PasswordFormFiled> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
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

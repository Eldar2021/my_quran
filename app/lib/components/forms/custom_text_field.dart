import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.controller,
    this.labelText,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    super.key,
  });

  final bool obscureText;
  final TextEditingController? controller;
  final String? labelText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        errorMaxLines: 3,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}

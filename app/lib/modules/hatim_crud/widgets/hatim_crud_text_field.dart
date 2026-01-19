import 'package:flutter/material.dart';

class HatimCrudTextField extends StatelessWidget {
  const HatimCrudTextField({
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.controller,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.onTap,
    this.suffixIcon,
    super.key,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Widget? prefixIcon;
  final int maxLines;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      minLines: 1,
      enabled: enabled,
      onTapOutside: (PointerDownEvent event) {
        FocusScope.of(context).unfocus();
      },
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: prefixIcon,
        ),
      ),
    );
  }
}

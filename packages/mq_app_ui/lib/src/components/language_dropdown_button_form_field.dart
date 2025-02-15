import 'package:flutter/material.dart';

class LanguageDropdownButtonFormField<T> extends StatelessWidget {
  const LanguageDropdownButtonFormField({
    required this.items,
    required this.itemBuilder,
    this.value,
    this.labelText,
    this.onChanged,
    super.key,
  });

  final T? value;
  final List<T> items;
  final DropdownMenuItem<T> Function(T?) itemBuilder;
  final String? labelText;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down),
      alignment: AlignmentDirectional.center,
      decoration: InputDecoration(labelText: labelText, prefixIcon: const Icon(Icons.translate)),
      items: items.map(itemBuilder).toList(),
      onChanged: onChanged,
    );
  }
}

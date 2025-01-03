import 'package:flutter/material.dart';

class LanguageDropdownButtonFormField<T> extends StatelessWidget {
  const LanguageDropdownButtonFormField({
    required this.items,
    required this.itemBuilder,
    this.value,
    this.labelText,
    super.key,
  });

  final T? value;
  final List<T> items;
  final DropdownMenuItem<T> Function(T?) itemBuilder;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down),
      alignment: AlignmentDirectional.center,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          Icons.translate,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      items: items.map(itemBuilder).toList(),
      onChanged: (Object? value) {},
    );
  }
}

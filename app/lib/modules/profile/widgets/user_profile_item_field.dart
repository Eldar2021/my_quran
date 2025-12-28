import 'package:flutter/material.dart';

class UserProfileItemField extends StatelessWidget {
  const UserProfileItemField({
    required this.title,
    required this.value,
    this.hintText,
    this.onEdit,
    super.key,
  });

  final String title;
  final String value;
  final String? hintText;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 6),
        TextFormField(
          readOnly: true,
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            fillColor: colorScheme.surfaceContainerLow,
            filled: true,
            suffixIcon: onEdit != null
                ? IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit),
                  )
                : null,
          ),
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar.buttonItems(
              anchors: editableTextState.contextMenuAnchors,
              buttonItems: editableTextState.contextMenuButtonItems,
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({required this.searchController, required this.searchFocusNode, this.onChanged, super.key});

  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isFocused = searchFocusNode.hasFocus;
    final fadedOnSurface = colorScheme.onSurface.withValues(alpha: 0.7);

    return SizedBox(
      height: 56,
      child: TextFormField(
        controller: searchController,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        focusNode: searchFocusNode,
        decoration: InputDecoration(
          hintText: isFocused ? null : context.l10n.searchEmailOrUsername,
          hintStyle: prTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Assets.icons.search.svg(
              colorFilter: ColorFilter.mode(isFocused ? colorScheme.primary : fadedOnSurface, BlendMode.srcIn),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: fadedOnSurface),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
      ),
    );
  }
}

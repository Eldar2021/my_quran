import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class GenderRedioWidget extends StatelessWidget {
  const GenderRedioWidget({required this.gender, this.itemIsMale = true, this.onChanged, this.title, super.key});

  final AppUiGender gender;
  final void Function(AppUiGender?)? onChanged;
  final String? title;
  final bool itemIsMale;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return RadioListTile<AppUiGender>(
      controlAffinity: ListTileControlAffinity.trailing,
      value: itemIsMale ? AppUiGender.male : AppUiGender.famela,
      groupValue: gender,
      onChanged: onChanged,
      secondary: itemIsMale
          ? Assets.icons.userMale.svg(
              colorFilter: ColorFilter.mode(selected ? colorScheme.primary : colorScheme.onSurface, BlendMode.srcIn),
            )
          : Assets.icons.userFemale.svg(
              colorFilter: ColorFilter.mode(selected ? colorScheme.primary : colorScheme.onSurface, BlendMode.srcIn),
            ),
      title: Text(
        title ?? '',
        style: textTheme.titleMedium?.copyWith(color: selected ? colorScheme.primary : colorScheme.onSurface),
      ),
      selected: selected,
      shape: Border(bottom: BorderSide(color: selected ? colorScheme.primary : colorScheme.onSurface)),
    );
  }

  bool get selected {
    return itemIsMale ? gender == AppUiGender.male : gender == AppUiGender.famela;
  }
}

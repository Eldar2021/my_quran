import 'package:flutter/material.dart';

enum AppUiGender {
  male,
  famela,
}

class GenderRedioWidget extends StatelessWidget {
  const GenderRedioWidget({
    required this.gender,
    this.itemIsMale = true,
    this.onChanged,
    this.title,
    super.key,
  });

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
      // secondary: Assets.images.backgroundBlue.image(),
      // secondary: Assets.icons.userMale.svg(
      //     // color: Colors.black,
      //     ),

      // secondary: Icon(Icons.book),
      // secondary: SvgPicture.asset(
      //   'assets/icons/book.svg',
      //   // itemIsMale ? Assets.icons.userMale.path : Assets.icons.userFemale.path,
      //   package: 'mq_app_ui',
      //   color: Colors.black,
      // ),
      title: Text(
        title ?? '',
        style: textTheme.titleMedium?.copyWith(
          color: selected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      selected: selected,
    );
  }

  bool get selected {
    return itemIsMale ? gender == AppUiGender.male : gender == AppUiGender.famela;
  }
}

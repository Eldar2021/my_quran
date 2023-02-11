import 'package:flutter/material.dart';
import 'package:hatim/constants/contants.dart';
import 'package:hatim/l10n/l10.dart';

import 'package:hatim/models/models.dart';

class GenderCard extends StatelessWidget {
  const GenderCard(
    this.gender, {
    required this.isSelect,
    required this.onTap,
    super.key,
  });

  final Gender gender;
  final bool isSelect;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        key: Key('login-${gender.name}'),
        leading: gender == Gender.male
            ? Assets.icons.male.svg(width: 35, color: colorScheme.onBackground)
            : Assets.icons.female.svg(width: 35),
        title: Text(gender == Gender.male ? context.l10n.male : context.l10n.female),
        onTap: onTap,
        trailing: isSelect
            ? CircleAvatar(
                radius: 15,
                backgroundColor: colorScheme.background,
                child: Icon(
                  Icons.check,
                  color: colorScheme.primary,
                ),
              )
            : null,
      ),
    );
  }
}

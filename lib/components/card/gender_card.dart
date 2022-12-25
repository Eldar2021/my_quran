import 'package:flutter/material.dart';

import 'package:hatim/models/models.dart';

class GenderCard extends StatelessWidget {
  const GenderCard(
    this.gender, {
    super.key,
    required this.isSelect,
    required this.onTap,
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
        leading: gender == Gender.male ? const Icon(Icons.male) : const Icon(Icons.female),
        title: Text(gender == Gender.male ? 'Male' : 'Female'),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/models/models.dart';

class SelectGender extends StatelessWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          'Please select Gender',
          style: TextStyle(fontSize: 24, color: colorScheme.onBackground),
        ),
        const SizedBox(height: 30),
        const GenderCard(Gender.male),
        const GenderCard(Gender.female),
      ],
    );
  }
}

class GenderCard extends StatelessWidget {
  const GenderCard(this.gender, {super.key});

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        key: Key('login-${gender.name}'),
        leading: gender == Gender.male ? const Icon(Icons.male) : const Icon(Icons.female),
        title: Text(gender == Gender.male ? 'Male' : 'Female'),
        onTap: () => context.read<AuthCubit>().setGender(gender),
        trailing: authCubit.state.gender == gender
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

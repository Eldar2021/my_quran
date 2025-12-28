import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class ProfileEditLastNameView extends StatefulWidget {
  const ProfileEditLastNameView(this.initialValue, {super.key});

  final String? initialValue;

  @override
  State<ProfileEditLastNameView> createState() => _ProfileEditLastNameViewState();
}

class _ProfileEditLastNameViewState extends State<ProfileEditLastNameView> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
      body: EditUserDataAsStringBody(
        formKey: _formKey,
        controller: _controller,
        hintText: 'Введите вашу фамилию',
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Введите вашу фамилию';
          } else if (value.trim() == widget.initialValue) {
            return 'Фамилия не может быть такой же как текущая';
          }
          return null;
        },
        onSave: (key, value) {
          context.read<ProfileCubit>().updateUserData(
            UpdateLastNameParam(userId: key, lastName: value),
          );
        },
      ),
    );
  }
}

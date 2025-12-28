import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class ProfileEditUserNameView extends StatefulWidget {
  const ProfileEditUserNameView(this.initialValue, {super.key});

  final String? initialValue;

  @override
  State<ProfileEditUserNameView> createState() => _ProfileEditUserNameViewState();
}

class _ProfileEditUserNameViewState extends State<ProfileEditUserNameView> {
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
        hintText: 'Введите ваше имя пользователя',
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Введите ваше имя пользователя';
          }
          if (value.trim() == widget.initialValue) {
            return 'Имя пользователя не может быть таким же как текущее';
          }
          return null;
        },
        onSave: (key, value) {
          context.read<ProfileCubit>().updateUserData(
            UpdateUsernameParam(userId: key, username: value),
          );
        },
      ),
    );
  }
}

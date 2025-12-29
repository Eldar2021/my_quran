import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class ProfileEditEmailView extends StatefulWidget {
  const ProfileEditEmailView(this.initialValue, {super.key});

  final String? initialValue;

  @override
  State<ProfileEditEmailView> createState() => _ProfileEditEmailViewState();
}

class _ProfileEditEmailViewState extends State<ProfileEditEmailView> {
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
        keyboardType: TextInputType.emailAddress,
        hintText: context.l10n.enterEmail2,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return context.l10n.enterEmail2;
          }
          if (value.trim() == widget.initialValue) {
            return context.l10n.emailSameAsCurrent;
          }
          return Validators.email(value, context);
        },
        onSave: (key, value) {
          context.read<ProfileCubit>().updateUserData(
            UpdateEmailParam(userId: key, email: value),
          );
        },
      ),
    );
  }
}

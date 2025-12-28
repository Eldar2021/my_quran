import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/cubit/auth_cubit.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class EditUserDataAsStringBody extends StatelessWidget {
  const EditUserDataAsStringBody({
    required this.formKey,
    required this.controller,
    required this.onSave,
    this.keyboardType = TextInputType.name,
    this.hintText,
    this.validator,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String key, String value) onSave;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              autofocus: true,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: colorScheme.surface,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: validator,
            ),
            const Spacer(),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileSuccess) {
                  _onSuccess(state.user, context);
                } else if (state is ProfileError) {
                  _onError(state.error, context);
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () => _onSave(context),
                  child: Text(context.l10n.save),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  void _onSuccess(AuthModel auth, BuildContext context) {
    context.read<AuthCubit>().updateAuth(auth);
    Navigator.pop(context);
  }

  void _onError(Object error, BuildContext context) {
    AppSnackbar.showError(context: context, title: error.toString());
  }

  void _onSave(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final firstName = controller.text.trim();
      final authKey = context.read<AuthCubit>().auth?.key ?? '';
      onSave(authKey, firstName);
    }
  }
}

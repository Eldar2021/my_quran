import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';
import 'dart:developer' as dev;

class ProfileEditPhoneNumberView extends StatefulWidget {
  const ProfileEditPhoneNumberView(this.initialValue, {super.key});

  final String initialValue;

  @override
  State<ProfileEditPhoneNumberView> createState() => _ProfileEditPhoneNumberViewState();
}

class _ProfileEditPhoneNumberViewState extends State<ProfileEditPhoneNumberView> {
  late final TextEditingController _controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  WorldCountry selectedCountry = WorldCountry.usa();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
    _parseInitialValue();
  }

  void _parseInitialValue() {
    if (widget.initialValue.isNotEmpty && widget.initialValue.contains('-')) {
      try {
        final item = widget.initialValue.split('-');
        if (item.length > 1) _controller.text = item[1];
        selectedCountry = WorldCountry.fromCode(item.last) ?? WorldCountry.usa();
      } on Object catch (e) {
        dev.log('_parseInitialValue', error: e);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getPhoneCode(WorldCountry country) {
    return '+${country.idd.root}${country.idd.suffixes.first}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l10n.pleaseEnterPhone;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: context.l10n.enterPhone,
                  fillColor: colorScheme.surface,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(left: 6),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<WorldCountry>(
                        value: selectedCountry,
                        isDense: true,
                        onChanged: (WorldCountry? newValue) {
                          if (newValue != null) {
                            setState(() => selectedCountry = newValue);
                          }
                        },
                        selectedItemBuilder: (context) {
                          return WorldCountry.all.map((e) {
                            return Text('${e.emoji} ${getPhoneCode(e)}');
                          }).toList();
                        },
                        items: WorldCountry.all.map((e) {
                          return DropdownMenuItem<WorldCountry>(
                            value: e,
                            child: Row(
                              children: [
                                Text(e.emoji),
                                Text(getPhoneCode(e)),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    e.commonNative,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileSuccess) {
                    _onSuccess(state.user);
                  } else if (state is ProfileError) {
                    _onError(state.error);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () => _onSave(context),
                    child: state.isLoading ? const CircularProgressIndicator() : Text(context.l10n.save),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }

  void _onSuccess(AuthModel auth) {
    context.read<AuthCubit>().updateAuth(auth);
    Navigator.pop(context);
  }

  void _onError(Object error) {
    AppSnackbar.showError(context: context, title: error.toString());
  }

  void _onSave(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final fullNumber = '${getPhoneCode(selectedCountry)}-${_controller.text}-${selectedCountry.code}';
      final authKey = context.read<AuthCubit>().auth?.key ?? '';
      context.read<ProfileCubit>().updateUserData(
        UpdatePhoneNumberParam(userId: authKey, phoneNumber: fullNumber),
      );
    }
  }
}

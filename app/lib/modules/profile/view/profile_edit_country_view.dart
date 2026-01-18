import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';
import 'dart:developer';

class ProfileEditCountryView extends StatefulWidget {
  const ProfileEditCountryView(this.initialValue, {super.key});

  final String initialValue;

  @override
  State<ProfileEditCountryView> createState() => _ProfileEditCountryViewState();
}

class _ProfileEditCountryViewState extends State<ProfileEditCountryView> {
  WorldCountry? selectedCountry;

  @override
  void initState() {
    super.initState();
    _parseInitialValue();
  }

  void _parseInitialValue() {
    if (widget.initialValue.isNotEmpty) {
      try {
        final a1 = widget.initialValue.split('-');
        selectedCountry = WorldCountry.fromCode(a1.last);
      } on Object catch (e) {
        log('_parseInitialCountryValue', error: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<WorldCountry>(
                  value: selectedCountry,
                  isExpanded: true,
                  hint: Text(context.l10n.selectCountry),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  borderRadius: BorderRadius.circular(16),
                  onChanged: (WorldCountry? newValue) {
                    if (newValue != null) {
                      setState(() => selectedCountry = newValue);
                    }
                  },
                  selectedItemBuilder: (context) {
                    return WorldCountry.all.map((e) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${e.emoji}  ${e.commonNative}'),
                      );
                    }).toList();
                  },
                  items: WorldCountry.all.map((e) {
                    return DropdownMenuItem<WorldCountry>(
                      value: e,
                      child: Row(
                        children: [
                          Text(e.emoji),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(e.commonNative),
                          ),
                          if (e == selectedCountry)
                            Icon(
                              Icons.check,
                              color: colorScheme.primary,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
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
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _onSave(context),
                    child: state.isLoading ? const CircularProgressIndicator() : Text(context.l10n.save),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
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
    if (selectedCountry != null) {
      final countryCode = '${selectedCountry!.emoji} ${selectedCountry!.commonEn}-${selectedCountry!.code}';
      final authKey = context.read<AuthCubit>().auth?.key ?? '';
      context.read<ProfileCubit>().updateUserData(
        UpdateCountryParam(userId: authKey, country: countryCode),
      );
    } else {
      AppSnackbar.showError(
        context: context,
        title: context.l10n.pleaseSelectCountry,
      );
    }
  }
}

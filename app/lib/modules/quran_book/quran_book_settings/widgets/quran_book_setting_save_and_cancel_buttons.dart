import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSettingSaveAndCancelButtons extends StatelessWidget {
  const QuranBookSettingSaveAndCancelButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OutlinedButton(
            key: const Key(MqKeys.quranReadSettingsBack),
            child: Text(context.l10n.cancel),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: ElevatedButton(
            key: const Key(MqKeys.quranReadSettingsSave),
            child: Text(context.l10n.save),
            onPressed: () async {
              await context.read<QuranBookSettingsCubit>().saveChanges();
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}

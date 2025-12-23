import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:mq_quran_repository/mq_quran_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

abstract class QuranAmenDialog {
  static Future<T?> showAmen<T>({
    required BuildContext context,
    required QuranAmenDialogContent content,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return BlocProvider(
          create: (context) => QuranAmenCubit(
            context.read<MqQuranRepository>(),
          ),
          child: content,
        );
      },
    );
  }
}

class QuranAmenDialogContent extends StatelessWidget {
  const QuranAmenDialogContent({
    required this.readThemeState,
    required this.pages,
    this.gender = Gender.male,
    this.hatimId,
    this.onAmen,
    super.key,
  });

  final QuranBookThemeState readThemeState;
  final List<int> pages;
  final Gender gender;
  final String? hatimId;
  final void Function(BuildContext context, bool result)? onAmen;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      backgroundColor: readThemeState.bgColor,
      contentTextStyle: textTheme.titleMedium?.copyWith(
        color: readThemeState.frColor,
      ),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: readThemeState.frColor,
      ),
      actionsAlignment: MainAxisAlignment.center,
      icon: switch (gender) {
        Gender.male => Assets.icons.userMale.svg(
          height: 100,
          colorFilter: ColorFilter.mode(
            readThemeState.frColor,
            BlendMode.srcIn,
          ),
        ),
        Gender.female => Assets.icons.userFemale.svg(
          height: 100,
          colorFilter: ColorFilter.mode(
            readThemeState.frColor,
            BlendMode.srcIn,
          ),
        ),
      },
      title: Text(context.l10n.amen),
      content: Text(
        context.l10n.dua,
        textAlign: TextAlign.center,
      ),
      actions: [
        BlocConsumer<QuranAmenCubit, QuranAmenState>(
          listener: (BuildContext context, QuranAmenState state) {
            if (state is QuranAmenSuccess) {
              onAmen!(context, true);
            } else if (state is QuranAmenError) {
              onAmen!(context, false);
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.maxFinite, 52),
              ),
              onPressed: state is QuranAmenLoading ? null : () => _onAmen(context),
              child: state is QuranAmenLoading ? const CupertinoActivityIndicator() : Text(context.l10n.ameen),
            );
          },
        ),
      ],
    );
  }

  void _onAmen(BuildContext context) {
    context.read<QuranAmenCubit>().amen(pages, hatimId: hatimId);
    if (hatimId == null && onAmen != null) {
      onAmen!(context, true);
    }
  }
}

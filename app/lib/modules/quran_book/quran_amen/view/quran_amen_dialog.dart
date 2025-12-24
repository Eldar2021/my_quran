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
    required this.confirmMessage,
    required this.pages,
    this.gender = Gender.male,
    this.hatimId,
    this.onAmen,
    super.key,
  });

  final QuranBookThemeState readThemeState;
  final List<int> pages;
  final Gender gender;
  final String confirmMessage;
  final String? hatimId;
  final void Function(BuildContext context, bool result)? onAmen;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final genderIcon = switch (gender) {
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
    };
    return AlertDialog(
      backgroundColor: readThemeState.bgColor,
      contentTextStyle: textTheme.titleMedium?.copyWith(
        color: readThemeState.frColor,
      ),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: readThemeState.frColor,
      ),
      actionsAlignment: MainAxisAlignment.center,
      iconPadding: EdgeInsets.zero,
      icon: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2, left: 4),
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.transparent),
              onPressed: null,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: genderIcon,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 4),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
      title: Text(
        context.l10n.amen,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: readThemeState.frColor,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.dua,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: readThemeState.frColor,
            ),
          ),
          const SizedBox(height: 16),
          Icon(
            Icons.info,
            color: readThemeState.frColor,
          ),
          const SizedBox(height: 6),
          Text(
            confirmMessage,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: readThemeState.frColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        BlocConsumer<QuranAmenCubit, QuranAmenState>(
          listener: (BuildContext context, QuranAmenState state) {
            if (state is QuranAmenSuccess) {
              context.read<HomeCubit>().getData();
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
    if (pages.isNotEmpty) {
      context.read<QuranAmenCubit>().amen(pages, hatimId: hatimId);
    }
  }
}

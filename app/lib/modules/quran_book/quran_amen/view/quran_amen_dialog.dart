import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_quran_client/mq_quran_client.dart';
import 'package:my_quran/modules/modules.dart';

class QuranAmenDialogContent extends StatelessWidget {
  const QuranAmenDialogContent(this.args, {super.key});

  final QuranAmenDialogContentArgs args;

  static Future<T?> showAmen<T>({
    required BuildContext context,
    required QuranAmenDialogContentArgs args,
    bool barrierDismissible = true,
  }) => showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => BlocProvider(
      create: (context) => QuranAmenCubit(
        context.read<QuranExtraRepository>(),
      ),
      child: QuranAmenDialogContent(args),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AlertDialog(
      backgroundColor: args.readThemeState.bgColor,
      contentTextStyle: textTheme.titleMedium?.copyWith(
        color: args.readThemeState.frColor,
      ),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: args.readThemeState.frColor,
      ),
      actionsAlignment: MainAxisAlignment.center,
      iconPadding: EdgeInsets.zero,
      icon: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const QuranAmenDialogCloseIconButton(color: Colors.transparent),
          Expanded(child: QuranAmenDialogGenderIconWidget(args)),
          QuranAmenDialogCloseIconButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      title: QuranAmenDialogTitle(args.readThemeState.frColor),
      content: QuranAmenDialogBody(args),
      actions: [
        BlocConsumer<QuranAmenCubit, QuranAmenState>(
          listener: (context, state) {
            if (state is QuranAmenSuccess) {
              context.read<HomeCubit>().getData();
              args.onAmen!(context, true);
            } else if (state is QuranAmenError) {
              args.onAmen!(context, false);
            }
          },
          builder: (context, state) {
            return QuranAmenDialogAmenButton(
              onAmen: state is QuranAmenLoading ? null : () => _onAmen(context),
              isloading: state is QuranAmenLoading,
            );
          },
        ),
      ],
    );
  }

  void _onAmen(BuildContext context) {
    if (args.pages.isNotEmpty) {
      context.read<QuranAmenCubit>().amen(args.pages, hatimId: args.hatimId);
    }
  }
}

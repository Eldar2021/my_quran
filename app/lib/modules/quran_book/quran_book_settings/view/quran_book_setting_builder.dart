import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/modules/modules.dart';

class QuranBookSettingBuilder extends StatelessWidget {
  const QuranBookSettingBuilder({
    required this.builder,
    this.buildWhen,
    super.key,
  });

  factory QuranBookSettingBuilder.changeSpace({
    required Widget Function(
      BuildContext context,
      double horizontal,
      double vertical,
    )
    builder,
  }) {
    return QuranBookSettingBuilder(
      buildWhen: (p, c) => p.horizontalSpaceSize != c.horizontalSpaceSize || p.verticalSpaceSize != c.verticalSpaceSize,
      builder: (context, state) => builder(
        context,
        state.horizontalSpaceSize,
        state.verticalSpaceSize,
      ),
    );
  }

  factory QuranBookSettingBuilder.changeThemeMode({
    required Widget Function(
      BuildContext context,
      Color bgColor,
      Color frColor,
    )
    builder,
  }) {
    return QuranBookSettingBuilder(
      buildWhen: (p, c) => p.modeIndex != c.modeIndex,
      builder: (context, state) => builder(context, state.bgColor, state.frColor),
    );
  }

  factory QuranBookSettingBuilder.changeTextTheme({
    required Widget Function(
      BuildContext context,
      double textSize,
      QuranFontType fontType,
    )
    builder,
  }) {
    return QuranBookSettingBuilder(
      buildWhen: (p, c) => p.textSize != c.textSize || p.fontType != c.fontType,
      builder: (context, state) => builder(
        context,
        state.textSize,
        state.fontType,
      ),
    );
  }

  final bool Function(
    QuranBookSettingsState,
    QuranBookSettingsState,
  )?
  buildWhen;

  final Widget Function(
    BuildContext,
    QuranBookSettingsState,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranBookSettingsCubit, QuranBookSettingsState>(
      buildWhen: buildWhen,
      builder: builder,
    );
  }
}

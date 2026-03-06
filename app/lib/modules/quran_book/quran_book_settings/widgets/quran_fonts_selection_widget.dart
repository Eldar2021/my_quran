import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class QuranFontsSelectionWidget extends StatefulWidget {
  const QuranFontsSelectionWidget({super.key});

  @override
  State<QuranFontsSelectionWidget> createState() => _QuranFontsSelectionWidgetState();
}

class _QuranFontsSelectionWidgetState extends State<QuranFontsSelectionWidget> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    final initialValue = context.read<QuranBookSettingsCubit>().state.fontType.indexValue;
    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: initialValue,
    )..addListener(() => _onChanged(_controller.index));
  }

  void _onChanged(int index) {
    final type = QuranFontType.fromIndex(index);
    context.read<QuranBookSettingsCubit>().changeFontType(type);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuranBookSettingBuilder.changeThemeMode(
          builder: (context, bgColor, frColor) {
            return Text(
              context.l10n.fontType,
              style: prTextTheme.titleMedium?.copyWith(color: frColor),
            );
          },
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ReadThemeData.bgReadThemeColor[1],
              border: Border.all(color: colors.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _TabBarView(_controller),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _TabBarView extends StatelessWidget {
  const _TabBarView(this.controller);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.onPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                controller: controller,
                indicator: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(3),
                labelColor: colors.onPrimary,
                labelStyle: textTheme.titleSmall,
                unselectedLabelColor: colors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: context.l10n.complex),
                  Tab(text: context.l10n.tajweed),
                  Tab(text: context.l10n.uthmani),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TabBarView(
              controller: controller,
              children: [
                Assets.images.normalFontExample.image(),
                Assets.images.tajweedExample.image(),
                Assets.images.uthmanicExample.image(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

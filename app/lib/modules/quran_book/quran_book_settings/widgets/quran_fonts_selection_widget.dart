import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:my_quran/modules/modules.dart';

class QuranFontsSelectionWidget extends StatefulWidget {
  const QuranFontsSelectionWidget({
    required this.onChanged,
    required this.initialIndex,
    super.key,
  });

  final int initialIndex;
  final void Function(QuranFontType type) onChanged;

  @override
  State<QuranFontsSelectionWidget> createState() => _QuranFontsSelectionWidgetState();
}

class _QuranFontsSelectionWidgetState extends State<QuranFontsSelectionWidget> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller =
        TabController(
          length: 3,
          vsync: this,
          initialIndex: widget.initialIndex,
        )..addListener(() {
          widget.onChanged(switch (_controller.index) {
            0 => QuranFontType.complex,
            1 => QuranFontType.tajweed,
            2 => QuranFontType.uthmanic,
            _ => QuranFontType.complex,
          });
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 150,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bgReadThemeColor[1],
          border: Border.all(color: colors.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    controller: _controller,
                    indicator: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(3),
                    labelColor: colors.onPrimary,
                    labelStyle: textTheme.titleMedium,
                    unselectedLabelColor: colors.onSurfaceVariant,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Комплекс'),
                      Tab(text: 'Таджвид'),
                      Tab(text: 'Усмани'),
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
                  controller: _controller,
                  children: [
                    Assets.images.normalFontExample.image(),
                    Assets.images.tajweedExample.image(),
                    Assets.images.uthmanicExample.image(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

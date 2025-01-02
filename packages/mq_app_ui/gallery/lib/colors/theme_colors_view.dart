import 'package:flutter/material.dart';

class ThemeColorsView extends StatelessWidget {
  const ThemeColorsView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ThemeColorsView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final colorItems = [
      _ColorSquare(
        name: 'Primary',
        color: colors.primary,
      ),
      _ColorSquare(
        name: 'On Primary',
        color: colors.onPrimary,
      ),
      _ColorSquare(
        name: 'Primary Container',
        color: colors.primaryContainer,
      ),
      _ColorSquare(
        name: 'On Primary Container',
        color: colors.onPrimaryContainer,
      ),
      _ColorSquare(
        name: 'Primary Fixed',
        color: colors.primaryFixed,
      ),
      _ColorSquare(
        name: 'Primary Fixed Dim',
        color: colors.primaryFixedDim,
      ),
      _ColorSquare(
        name: 'On Primary Fixed',
        color: colors.onPrimaryFixed,
      ),
      _ColorSquare(
        name: 'On Primary Fixed Variant',
        color: colors.onPrimaryFixedVariant,
      ),
      _ColorSquare(
        name: 'Secondary',
        color: colors.secondary,
      ),
      _ColorSquare(
        name: 'On Secondary',
        color: colors.onSecondary,
      ),
      _ColorSquare(
        name: 'Secondary Container',
        color: colors.secondaryContainer,
      ),
      _ColorSquare(
        name: 'On Secondary Container',
        color: colors.onSecondaryContainer,
      ),
      _ColorSquare(
        name: 'Secondary Fixed',
        color: colors.secondaryFixed,
      ),
      _ColorSquare(
        name: 'Secondary Fixed Dim',
        color: colors.secondaryFixedDim,
      ),
      _ColorSquare(
        name: 'On Secondary Fixed',
        color: colors.onSecondaryFixed,
      ),
      _ColorSquare(
        name: 'On Secondary Fixed Variant',
        color: colors.onSecondaryFixedVariant,
      ),
      _ColorSquare(
        name: 'Tertiary',
        color: colors.tertiary,
      ),
      _ColorSquare(
        name: 'On Tertiary',
        color: colors.onTertiary,
      ),
      _ColorSquare(
        name: 'Tertiary Container',
        color: colors.tertiaryContainer,
      ),
      _ColorSquare(
        name: 'On Tertiary Container',
        color: colors.onTertiaryContainer,
      ),
      _ColorSquare(
        name: 'Tertiary Fixed',
        color: colors.tertiaryFixed,
      ),
      _ColorSquare(
        name: 'Tertiary Fixed Dim',
        color: colors.tertiaryFixedDim,
      ),
      _ColorSquare(
        name: 'On Tertiary Fixed',
        color: colors.onTertiaryFixed,
      ),
      _ColorSquare(
        name: 'On Tertiary Fixed Variant',
        color: colors.onTertiaryFixedVariant,
      ),
      _ColorSquare(
        name: 'Error',
        color: colors.error,
      ),
      _ColorSquare(
        name: 'On Error',
        color: colors.onError,
      ),
      _ColorSquare(
        name: 'Error Container',
        color: colors.errorContainer,
      ),
      _ColorSquare(
        name: 'On Error Container',
        color: colors.onErrorContainer,
      ),
      _ColorSquare(
        name: 'Outline',
        color: colors.outline,
      ),
      _ColorSquare(
        name: 'Outline Variant',
        color: colors.outlineVariant,
      ),
      _ColorSquare(
        name: 'Surface',
        color: colors.surface,
      ),
      _ColorSquare(
        name: 'Surface Dim',
        color: colors.surfaceDim,
      ),
      _ColorSquare(
        name: 'Surface Bright',
        color: colors.surfaceBright,
      ),
      _ColorSquare(
        name: 'Surface Container Lowest',
        color: colors.surfaceContainerLowest,
      ),
      _ColorSquare(
        name: 'Surface Container Low',
        color: colors.surfaceContainerLow,
      ),
      _ColorSquare(
        name: 'Surface Container',
        color: colors.surfaceContainer,
      ),
      _ColorSquare(
        name: 'Surface Container High',
        color: colors.surfaceContainerHigh,
      ),
      _ColorSquare(
        name: 'Surface Container Highest',
        color: colors.surfaceContainerHighest,
      ),
      _ColorSquare(
        name: 'On Surface',
        color: colors.onSurface,
      ),
      _ColorSquare(
        name: 'On Surface Variant',
        color: colors.onSurfaceVariant,
      ),
      _ColorSquare(
        name: 'Inverse Surface',
        color: colors.inverseSurface,
      ),
      _ColorSquare(
        name: 'On Inverse Surface',
        color: colors.onInverseSurface,
      ),
      _ColorSquare(
        name: 'Inverse Primary',
        color: colors.inversePrimary,
      ),
      _ColorSquare(
        name: 'Shadow',
        color: colors.shadow,
      ),
      _ColorSquare(
        name: 'Scrim',
        color: colors.scrim,
      ),
      _ColorSquare(
        name: 'Surface Tint',
        color: colors.surfaceTint,
      ),
      _ColorSquare(
        name: 'Background!',
        // ignore: deprecated_member_use
        color: colors.background,
      ),
      _ColorSquare(
        name: 'On Background!',
        // ignore: deprecated_member_use
        color: colors.onBackground,
      ),
      _ColorSquare(
        name: 'Surface Variant!',
        // ignore: deprecated_member_use
        color: colors.surfaceVariant,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Colors')),
      body: GridView.builder(
        itemCount: colorItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (_, index) => colorItems[index],
      ),
    );
  }
}

class _ColorSquare extends StatelessWidget {
  const _ColorSquare({
    required this.color,
    required this.name,
  });

  final Color color;
  final String name;

  TextStyle get textStyle {
    return TextStyle(
      color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
    );
  }

  String get hexCode {
    if (color.value.toRadixString(16).length <= 2) {
      return '--';
    } else {
      return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              hexCode,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

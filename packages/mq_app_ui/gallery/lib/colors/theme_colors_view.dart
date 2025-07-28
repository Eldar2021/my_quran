import 'package:flutter/material.dart';

class ThemeColorsView extends StatelessWidget {
  const ThemeColorsView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ThemeColorsView());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final colorItems = [
      ColorSquare(name: 'Primary', color: colors.primary),
      ColorSquare(name: 'On Primary', color: colors.onPrimary),
      ColorSquare(name: 'Primary Container', color: colors.primaryContainer),
      ColorSquare(name: 'On Primary Container', color: colors.onPrimaryContainer),
      ColorSquare(name: 'Primary Fixed', color: colors.primaryFixed),
      ColorSquare(name: 'Primary Fixed Dim', color: colors.primaryFixedDim),
      ColorSquare(name: 'On Primary Fixed', color: colors.onPrimaryFixed),
      ColorSquare(name: 'On Primary Fixed Variant', color: colors.onPrimaryFixedVariant),
      ColorSquare(name: 'Secondary', color: colors.secondary),
      ColorSquare(name: 'On Secondary', color: colors.onSecondary),
      ColorSquare(name: 'Secondary Container', color: colors.secondaryContainer),
      ColorSquare(name: 'On Secondary Container', color: colors.onSecondaryContainer),
      ColorSquare(name: 'Secondary Fixed', color: colors.secondaryFixed),
      ColorSquare(name: 'Secondary Fixed Dim', color: colors.secondaryFixedDim),
      ColorSquare(name: 'On Secondary Fixed', color: colors.onSecondaryFixed),
      ColorSquare(name: 'On Secondary Fixed Variant', color: colors.onSecondaryFixedVariant),
      ColorSquare(name: 'Tertiary', color: colors.tertiary),
      ColorSquare(name: 'On Tertiary', color: colors.onTertiary),
      ColorSquare(name: 'Tertiary Container', color: colors.tertiaryContainer),
      ColorSquare(name: 'On Tertiary Container', color: colors.onTertiaryContainer),
      ColorSquare(name: 'Tertiary Fixed', color: colors.tertiaryFixed),
      ColorSquare(name: 'Tertiary Fixed Dim', color: colors.tertiaryFixedDim),
      ColorSquare(name: 'On Tertiary Fixed', color: colors.onTertiaryFixed),
      ColorSquare(name: 'On Tertiary Fixed Variant', color: colors.onTertiaryFixedVariant),
      ColorSquare(name: 'Error', color: colors.error),
      ColorSquare(name: 'On Error', color: colors.onError),
      ColorSquare(name: 'Error Container', color: colors.errorContainer),
      ColorSquare(name: 'On Error Container', color: colors.onErrorContainer),
      ColorSquare(name: 'Outline', color: colors.outline),
      ColorSquare(name: 'Outline Variant', color: colors.outlineVariant),
      ColorSquare(name: 'Surface', color: colors.surface),
      ColorSquare(name: 'Surface Dim', color: colors.surfaceDim),
      ColorSquare(name: 'Surface Bright', color: colors.surfaceBright),
      ColorSquare(name: 'Surface Container Lowest', color: colors.surfaceContainerLowest),
      ColorSquare(name: 'Surface Container Low', color: colors.surfaceContainerLow),
      ColorSquare(name: 'Surface Container', color: colors.surfaceContainer),
      ColorSquare(name: 'Surface Container High', color: colors.surfaceContainerHigh),
      ColorSquare(name: 'Surface Container Highest', color: colors.surfaceContainerHighest),
      ColorSquare(name: 'On Surface', color: colors.onSurface),
      ColorSquare(name: 'On Surface Variant', color: colors.onSurfaceVariant),
      ColorSquare(name: 'Inverse Surface', color: colors.inverseSurface),
      ColorSquare(name: 'On Inverse Surface', color: colors.onInverseSurface),
      ColorSquare(name: 'Inverse Primary', color: colors.inversePrimary),
      ColorSquare(name: 'Shadow', color: colors.shadow),
      ColorSquare(name: 'Scrim', color: colors.scrim),
      ColorSquare(name: 'Surface Tint', color: colors.surfaceTint),
      ColorSquare(
        name: 'Background!',
        // deprecated
        // ignore: deprecated_member_use
        color: colors.background,
      ),
      ColorSquare(
        name: 'On Background!',
        // deprecated
        // ignore: deprecated_member_use
        color: colors.onBackground,
      ),
      ColorSquare(
        name: 'Surface Variant!',
        // deprecated
        // ignore: deprecated_member_use
        color: colors.surfaceVariant,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Colors')),
      body: GridView.builder(
        itemCount: colorItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (_, index) => colorItems[index],
      ),
    );
  }
}

class ColorSquare extends StatelessWidget {
  const ColorSquare({required this.color, required this.name, super.key});

  final Color color;
  final String name;

  TextStyle get textStyle {
    return TextStyle(color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white);
  }

  String get hexCode {
    if (color.toARGB32().toRadixString(16).length <= 2) return '--';
    return '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(name, style: textStyle, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(hexCode, style: textStyle, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}

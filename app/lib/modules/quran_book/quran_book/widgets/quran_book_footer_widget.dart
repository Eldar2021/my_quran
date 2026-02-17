import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';

class QuranBookFooterWidget extends StatelessWidget {
  const QuranBookFooterWidget({
    this.nextButtonText,
    this.previousButtonText,
    this.onNext,
    this.onPrevious,
    this.onAmeen,
    super.key,
  });

  final void Function()? onNext;
  final String? nextButtonText;
  final void Function()? onPrevious;
  final String? previousButtonText;
  final void Function()? onAmeen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QuranBookFooterNavigationButton(
              onTap: onNext,
              icon: const Icon(Icons.arrow_back_ios),
              text: nextButtonText,
            ),
            QuranBookFooterNavigationButton(
              onTap: onPrevious,
              iconAlignment: IconAlignment.end,
              text: previousButtonText,
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (onAmeen != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: ElevatedButton(
              onPressed: onAmeen,
              child: Text(context.l10n.readed),
            ),
          ),
      ],
    );
  }
}

class QuranBookFooterNavigationButton extends StatelessWidget {
  const QuranBookFooterNavigationButton({
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.iconAlignment = IconAlignment.start,
    this.icon = const Icon(Icons.arrow_forward_ios),
    this.onTap,
    this.text,
    super.key,
  });

  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final IconAlignment iconAlignment;
  final Widget icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Visibility(
        visible: text != null,
        child: TextButton.icon(
          onPressed: onTap,
          iconAlignment: iconAlignment,
          label: Text(text ?? ''),
          icon: icon,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

abstract class MqBottomSheets {
  static Future<T?> showConfirmSheet<T>({
    required BuildContext context,
    String title = 'Title',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDismissible = true,
    void Function()? onConfirm,
    void Function()? onCancel,
    String? content,
    String? confirmKey,
    String? cancelKey,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      builder: (context) {
        final prTextTheme = Theme.of(context).primaryTextTheme;
        final colorScheme = Theme.of(context).colorScheme;
        return SizedBox.fromSize(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 22),
                Text(
                  title,
                  style: prTextTheme.headlineSmall,
                ),
                const SizedBox(height: 14),
                Divider(
                  color: colorScheme.inversePrimary,
                ),
                const SizedBox(height: 14),
                if (content != null)
                  Text(
                    content,
                    style: prTextTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        key: cancelKey != null ? Key(cancelKey) : null,
                        onPressed: onCancel,
                        child: Text(cancelText),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        key: confirmKey != null ? Key(confirmKey) : null,
                        onPressed: onConfirm,
                        child: Text(confirmText),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<T?> showReadSettingsSheet<T>({
    required BuildContext context,
    String title = 'Title',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDismissible = true,
    void Function()? onConfirm,
    void Function()? onCancel,
    String? content,
    String? confirmKey,
    String? cancelKey,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      // enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        // final prTextTheme = Theme.of(context).primaryTextTheme;
        // final colorScheme = Theme.of(context).colorScheme;
        return SizedBox.fromSize(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: _Body(),
          ),
        );
      },
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  double textSize = 0.3;

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    // final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Translation',
            style: prTextTheme.titleMedium,
          ),
          value: true,
          onChanged: (v) {},
        ),
        const SizedBox(height: 10),
        Text(
          'Text size',
          style: prTextTheme.titleMedium,
        ),
        Row(
          children: [
            Assets.icons.aDigit.svg(
              width: 12,
            ),
            Expanded(
              child: Slider.adaptive(
                value: textSize,
                onChanged: (v) {
                  setState(() {
                    textSize = v;
                  });
                },
              ),
            ),
            Assets.icons.aDigit.svg(),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Vertical space',
          style: prTextTheme.titleMedium,
        ),
        Row(
          children: [
            Assets.icons.aDigitVerticalSmall.svg(),
            Expanded(
              child: Slider.adaptive(
                value: textSize,
                onChanged: (v) {
                  setState(() {
                    textSize = v;
                  });
                },
              ),
            ),
            Assets.icons.aDigitVertical.svg(),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Horizontal space',
          style: prTextTheme.titleMedium,
        ),
        Row(
          children: [
            // Icon(Icons.format_l),
            // FaIcon(FontAwesomeIcons.letterboxd),
            Assets.icons.aHorizontal.svg(),
            Expanded(
              child: Slider.adaptive(
                value: textSize,
                onChanged: (v) {
                  setState(() {
                    textSize = v;
                  });
                },
              ),
            ),
            Assets.icons.aHorizontalBig.svg(),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

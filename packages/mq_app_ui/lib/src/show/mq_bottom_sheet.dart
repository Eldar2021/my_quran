import 'package:flutter/material.dart';

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
                Text(title, style: prTextTheme.headlineSmall),
                const SizedBox(height: 14),
                Divider(color: colorScheme.inversePrimary),
                const SizedBox(height: 14),
                if (content != null) Text(content, style: prTextTheme.titleMedium, textAlign: TextAlign.center),
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
    required Widget child,
    bool isDismissible = true,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      builder: (context) => child,
    );
  }
}

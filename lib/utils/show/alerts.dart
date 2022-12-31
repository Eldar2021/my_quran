import 'package:flutter/cupertino.dart';
import 'package:hatim/l10n/l10.dart';

class AppAlert {
  static Future<T?> showLoading<T>(BuildContext context) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(context.l10n.localeName),
          content: const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}

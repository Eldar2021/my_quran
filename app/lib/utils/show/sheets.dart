import 'package:flutter/material.dart';

@immutable
final class AppBottomSheet {
  static Future<T?> showBottomSheet<T>(
    BuildContext context,
    Widget child, {
    double initialChildSize = 0.6,
    Key? scrollKey,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (c, s) {
            return Column(
              children: [
                const SizedBox(height: 8),
                const SizedBox(
                  height: 30,
                  child: Icon(Icons.maximize_rounded, size: 50),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    key: scrollKey,
                    physics: const BouncingScrollPhysics(),
                    controller: s,
                    child: child,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

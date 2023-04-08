import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<T?> showBottomSheet<T>(BuildContext context, Widget Function(BuildContext, ScrollController) builder) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: builder,
        );
      },
    );
  }
}

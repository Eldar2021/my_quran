import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<T?> showBottomSheet<T>(BuildContext context, Widget Function(BuildContext) builder) async {
    return showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: builder,
    );
  }
}

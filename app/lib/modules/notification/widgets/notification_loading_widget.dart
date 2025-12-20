import 'package:flutter/material.dart';

class NotificationLoadingWidget extends StatelessWidget {
  const NotificationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

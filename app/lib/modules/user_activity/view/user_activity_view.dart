import 'package:flutter/material.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

class UserActivityView extends StatelessWidget {
  const UserActivityView(this.data, {super.key});

  final Map<DateTime, List<UserActivityModel>> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Activity'),
      ),
    );
  }
}

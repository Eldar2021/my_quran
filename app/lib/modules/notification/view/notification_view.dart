import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/modules/modules.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state.user;
    context.read<NotificationCubit>().getNotification(user?.localeCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return switch (state) {
            NotificationInitial() => const Center(child: CircularProgressIndicator.adaptive()),
            NotificationSuccess() => ListView.builder(
              itemCount: state.notifications?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.notifications?[index].title ?? ''),
                  subtitle: Text(state.notifications?[index].body ?? ''),
                );
              },
            ),
            NotificationError() => const Center(
              child: Text('Not found notifications'),
            ),
          };
        },
      ),
    );
  }
}

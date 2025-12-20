import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/show/snackbars.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> with NotificationDevMixin {
  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthCubit>().state.auth;
    context.read<NotificationCubit>().getNotification(
      auth?.user.language,
      auth?.key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: InkWell(
          onDoubleTap: () => showDevDialog(context),
          child: Text(context.l10n.notifications),
        ),
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          final fetchState = state.fetchState;
          if (fetchState is NotificationFetchError) {
            _onError(fetchState.error);
          }
        },
        builder: (context, state) {
          final fetchState = state.fetchState;
          return switch (fetchState) {
            NotificationFetchInitial() => const NotificationLoadingWidget(),
            NotificationFetchLoading() => const NotificationLoadingWidget(),
            NotificationFetchSuccess() => NotificationListWidget(
              notifications: fetchState.notifications ?? [],
            ),
            NotificationFetchError() => const NotificationEmptyState(),
          };
        },
      ),
    );
  }

  void _onError(Object error) {
    AppSnackbar.showError(
      context: context,
      title: error.toString(),
    );
  }
}

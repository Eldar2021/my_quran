import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/modules/home/cubit/home_cubit.dart';

class ShowInvitationWidget {
  static Future<T?> showInvitationSheet<T>({
    required BuildContext context,
    List<MqHomeInvitedHatimsModel> invitedHatims = const [],
    String? confirmKey,
    String? cancelKey,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final prTextTheme = Theme.of(context).primaryTextTheme;
        final colorScheme = Theme.of(context).colorScheme;

        final maxHeight = MediaQuery.of(context).size.height - 120;

        return Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
          ),
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 57,
                height: 6,
                decoration: BoxDecoration(color: colorScheme.inverseSurface, borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(height: 22),
              Text('Invitations', style: prTextTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'Below, you will find invitations from people\nwho want you to join their Hatim',
                textAlign: TextAlign.center,
                style: prTextTheme.titleSmall,
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: invitedHatims.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  itemBuilder: (context, index) {
                    final item = invitedHatims[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GradientDecoratedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: Column(
                            children: [
                              Text(item.title ?? '', style: prTextTheme.titleMedium),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  item.description ?? '',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: prTextTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Hatim created by:\n${item.creator?.firstName ?? ''} ${item.creator?.lastName ?? ''}',
                                textAlign: TextAlign.center,
                                style: prTextTheme.bodySmall,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      // key: cancelKey != null ? Key(cancelKey) : null,
                                      onPressed: () {
                                        try {
                                          context.read<HomeCubit>().hatimReject(item.id);
                                        } on Exception catch (e) {
                                          log(e.toString());
                                        }
                                      },
                                      child: const Text('Decline'),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      // key: confirmKey != null ? Key(confirmKey) : null,
                                      onPressed: () {
                                        try {
                                          context.read<HomeCubit>().hatimAccept(item.id);
                                        } on Exception catch (e) {
                                          log(e.toString());
                                        }
                                      },
                                      child: const Text('Accept'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_home_repository/mq_home_repository.dart';
import 'package:my_quran/l10n/l10.dart';
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
      builder: (ctx) {
        return _InvitationSheet(invitedHatims: List.from(invitedHatims), confirmKey: confirmKey, cancelKey: cancelKey);
      },
    );
  }
}

class _InvitationSheet extends StatefulWidget {
  const _InvitationSheet({required this.invitedHatims, this.confirmKey, this.cancelKey});
  final List<MqHomeInvitedHatimsModel> invitedHatims;
  final String? confirmKey;
  final String? cancelKey;

  @override
  State<_InvitationSheet> createState() => _InvitationSheetState();
}

class _InvitationSheetState extends State<_InvitationSheet> with SingleTickerProviderStateMixin {
  late final GlobalKey<AnimatedListState> _listKey;
  late List<MqHomeInvitedHatimsModel> _items;

  @override
  void initState() {
    super.initState();
    _listKey = GlobalKey<AnimatedListState>();
    _items = widget.invitedHatims;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
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
          Text(context.l10n.invitations, style: prTextTheme.titleLarge),
          const SizedBox(height: 8),
          Text(context.l10n.invitationsDescription, textAlign: TextAlign.center, style: prTextTheme.titleSmall),
          Flexible(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              itemBuilder: (context, index, animation) {
                return _buildItem(_items[index], index, animation);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _removeItem(int index, {required bool accepted}) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(sizeFactor: animation, child: _buildItem(removedItem, index, animation)),
    );

    if (accepted) {
      context.read<HomeCubit>().hatimAccept(removedItem.id);
    } else {
      context.read<HomeCubit>().hatimReject(removedItem.id);
    }

    if (_items.isEmpty) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  Widget _buildItem(MqHomeInvitedHatimsModel item, int index, Animation<double> animation) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return FadeTransition(
      opacity: animation,
      child: Padding(
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
                  '${context.l10n.hatimCreatedBy}\n${((item.creator?.firstName != null && item.creator!.firstName!.isNotEmpty) || (item.creator?.lastName != null && item.creator!.lastName!.isNotEmpty)) ? '${item.creator?.firstName ?? ''} ${item.creator?.lastName ?? ''}' : (item.creator?.userName ?? '')}',
                  textAlign: TextAlign.center,
                  style: prTextTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _removeItem(index, accepted: false),
                        child: Text(
                          context.l10n.decline,
                          key: widget.cancelKey != null ? Key(widget.cancelKey!) : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _removeItem(index, accepted: true),
                        child: Text(
                          context.l10n.accept,
                          key: widget.confirmKey != null ? Key(widget.confirmKey!) : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

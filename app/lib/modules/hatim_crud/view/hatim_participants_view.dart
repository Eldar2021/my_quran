import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HatimParticipantsView extends StatefulWidget {
  const HatimParticipantsView({
    required this.onAddParticipant,
    required this.onRemoveParticipant,
    super.key,
  });

  final void Function(MqUserIdModel user) onAddParticipant;
  final void Function(MqUserIdModel user) onRemoveParticipant;

  static Future<void> show({
    required BuildContext context,
    required void Function(MqUserIdModel user) onAddParticipant,
    required void Function(MqUserIdModel user) onRemoveParticipant,
    required List<MqUserIdModel> initialParticipants,
  }) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => BlocProvider(
          create: (context) => HatimCrudParticipantsCubit(
            repository: context.read<MqHatimRepository>(),
            participants: initialParticipants.toSet(),
          ),
          child: HatimParticipantsView(
            onAddParticipant: onAddParticipant,
            onRemoveParticipant: onRemoveParticipant,
          ),
        ),
      ),
    );
  }

  @override
  State<HatimParticipantsView> createState() => _HatimParticipantsViewState();
}

class _HatimParticipantsViewState extends State<HatimParticipantsView> {
  late final Debouncer _debouncer;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _debouncer = Debouncer();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      key: const Key(MqKeys.search),
      appBar: AppBar(
        title: Text(context.l10n.addParticipants),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (value) {
                if (value.trim().length >= 3) {
                  _debouncer.debounce(() {
                    context.read<HatimCrudParticipantsCubit>().search(value);
                  });
                }
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<HatimCrudParticipantsCubit, HatimCrudParticipantsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, value, child) {
                  if (value.text.length >= 3) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      context.l10n.queryMinLength,
                      style: prTextTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              if (state.participants.isNotEmpty)
                ParticipantsListWidget(
                  participants: state.participants.toList(),
                  onRemoveParticipant: (item) {
                    context.read<HatimCrudParticipantsCubit>().removeParticipant(item);
                    widget.onRemoveParticipant(item);
                  },
                ),
              const SizedBox(height: 20),
              Text(
                context.l10n.allUsers,
                style: prTextTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ParticipantsSearchWidget(
                state: state.searchState,
                participants: state.participants.toList(),
                onAddParticipant: (user) {
                  widget.onAddParticipant(user);
                  context.read<HatimCrudParticipantsCubit>().addParticipant(user);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

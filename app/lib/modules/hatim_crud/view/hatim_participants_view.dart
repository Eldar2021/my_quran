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

  static void show({
    required BuildContext context,
    required void Function(MqUserIdModel user) onAddParticipant,
    required void Function(MqUserIdModel user) onRemoveParticipant,
    required List<MqUserIdModel> initialParticipants,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => BlocProvider(
          create: (context) => HatimCrudParticipantsCubit(
            repository: context.read<MqHatimRepository>(),
            participants: initialParticipants,
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
    return Scaffold(
      key: const Key(MqKeys.search),
      appBar: AppBar(
        title: Text(context.l10n.addParticipants),
        centerTitle: true,
      ),
    );
  }
}

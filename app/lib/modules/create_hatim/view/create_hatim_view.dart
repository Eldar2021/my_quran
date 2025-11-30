import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:mq_remote_client/mq_remote_client.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/config/router/app_router.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class CreateHatimView extends StatelessWidget {
  const CreateHatimView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateHatimCubit(
        MqHatimReadRepositoryImpl(
          dataSource: context.read<AppConfig>().isMockData
              ? MqHatimRemoteDataSourceMock()
              : MqHatimRemoteDataSourceImpl(
                  remoteClient: context.read<MqRemoteClient>(),
                ),
        ),
      ),
      child: const CreateHatimViewBody(),
    );
  }
}

class CreateHatimViewBody extends StatefulWidget {
  const CreateHatimViewBody({super.key});

  @override
  State<CreateHatimViewBody> createState() => _CreateHatimViewBodyState();
}

class _CreateHatimViewBodyState extends State<CreateHatimViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController()..addListener(_onSetState);
    _descriptionController = TextEditingController()..addListener(_onSetState);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: const Key(MqKeys.createHatim),
      appBar: AppBar(
        title: Text(context.l10n.createHatim),
        centerTitle: true,
      ),
      body: BlocConsumer<CreateHatimCubit, CreateHatimState>(
        listener: (BuildContext context, CreateHatimState state) {
          if (state.hatimModel != null) {
            context.goNamed(AppRouter.createHatimSuccess);
          } else if (state.exception != null) {
            AppSnackbar.showError(
              context: context,
              title: state.exception.toString(),
            );
          }
        },
        builder: (context, state) {
          final participants = state.selectedUsers;

          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabel(title: context.l10n.title),
                  TextFormField(
                    key: const Key(MqKeys.titleTextField),
                    controller: _titleController,
                    validator: (value) {
                      return (value == null || value.isEmpty) ? context.l10n.enterHatimTitle : null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Assets.icons.title.svg(
                          colorFilter: ColorFilter.mode(
                            colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      hintText: context.l10n.enterHatimTitleHere,
                    ),
                  ),
                  const SizedBox(height: 26),
                  FormLabel(title: context.l10n.description),
                  TextFormField(
                    key: const Key(MqKeys.descriptionTextField),
                    controller: _descriptionController,
                    maxLines: null,
                    validator: (value) {
                      return (value == null || value.isEmpty) ? context.l10n.enterHatimDescription : null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Assets.icons.fluentDescription.svg(
                          colorFilter: ColorFilter.mode(
                            colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      hintText: context.l10n.enterHatimDescriptionHere,
                    ),
                  ),
                  const SizedBox(height: 26),
                  FormLabel(title: context.l10n.participants),
                  TextFormField(
                    onTap: () => _pickParticipants(context),
                    validator: (_) {
                      return participants.isEmpty ? context.l10n.addParticipantsToHatim : null;
                    },
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Assets.icons.solidUsers.svg(
                          colorFilter: ColorFilter.mode(
                            colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      hintText: context.l10n.addParticipantsToYourHatim,
                      suffixIcon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: colorScheme.inverseSurface,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (participants.isNotEmpty) ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: participants.length,
                        padding: const EdgeInsets.only(bottom: 90),
                        itemBuilder: (context, index) {
                          final user = participants[index];
                          return ParticipantTile(
                            user: user,
                            text: context.l10n.remove,
                            isOutlined: true,
                            onPressed: () {
                              context.read<CreateHatimCubit>().removeParticipant(user);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<CreateHatimCubit, CreateHatimState>(
          builder: (context, state) {
            final loading = state.status == FetchStatus.loading;
            final canSubmit = !loading && _isFormFilled;

            return ElevatedButton(
              key: const Key(MqKeys.createHatimButton),
              onPressed: canSubmit ? _onSubmit : null,
              child: loading
                  ? const SizedBox.square(
                      dimension: 25,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(context.l10n.createHatim),
            );
          },
        ),
      ),
    );
  }

  void _onSetState() {
    setState(() {});
  }

  bool get _isFormFilled {
    final title = _titleController.text.trim();
    final desc = _descriptionController.text.trim();
    final participants = context.read<CreateHatimCubit>().state.selectedUsers;
    return title.isNotEmpty && desc.isNotEmpty && participants.isNotEmpty;
  }

  Future<void> _pickParticipants(BuildContext context) async {
    final cubit = context.read<CreateHatimCubit>();

    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: const SearchView(),
        ),
      ),
    );

    if (mounted) {
      _onSetState();
      _formKey.currentState?.validate();
    }
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() != true) return;

    final participants = context.read<CreateHatimCubit>().state.selectedUsers;

    final model = MqHatimCreateModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      type: 'GROUP',
      participants: participants.map((u) => u.id.toString()).toList(),
    );

    context.read<CreateHatimCubit>().createHatim(model);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }
}

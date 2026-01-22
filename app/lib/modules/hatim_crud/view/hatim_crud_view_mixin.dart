part of 'hatim_crud_view.dart';

mixin HatimCrudViewMixin on State<HatimCrudViewBody> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleCtl;
  late final TextEditingController _descriptionCtl;
  late final ValueNotifier<List<MqUserIdModel>> _participants;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _titleCtl = TextEditingController();
    _descriptionCtl = TextEditingController();
    _participants = ValueNotifier([]);
    super.initState();
    final bloc = context.read<HatimCrudBloc>();
    if (bloc.hatimId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.add(GetHatimDataByIdEvent(bloc.hatimId!));
      });
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _titleCtl.dispose();
    _descriptionCtl.dispose();
    _participants.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final bloc = context.read<HatimCrudBloc>();
    final data = MqHatimCreateModel(
      title: _titleCtl.text,
      description: _descriptionCtl.text,
      participants: _participants.value.map((e) => e.id.toString()).toList(),
      type: 'GROUP',
    );
    if (bloc.hatimId != null) {
      final eventData = MqHatimUpdateModel(id: bloc.hatimId!, data: data);
      bloc.add(UpdateHatimByIdEvent(eventData));
    } else {
      bloc.add(CreateHatimEvent(data));
    }
  }

  void _removeParticipant(MqUserIdModel user) {
    _participants.value = List.from(_participants.value)..remove(user);
  }

  void _onDeleteError(Object error) {
    AppSnackbar.showError(
      context: context,
      title: error.toString(),
    );
  }

  void _onDeleteSuccess() {
    HatimCrudSuccesView.show(
      context: context,
      title: context.l10n.hatimDeleted,
      description: context.l10n.hatimDeletedSuccessfully,
    );
  }

  void _onUpdateError(Object error) {
    AppSnackbar.showError(
      context: context,
      title: error.toString(),
    );
  }

  void _onUpdateSuccess(MqHatimModel? data) {
    HatimCrudSuccesView.show(
      context: context,
      title: context.l10n.hatimUpdated,
      description: context.l10n.hatimDescription,
    );
  }

  void _onCreateError(Object error) {
    AppSnackbar.showError(
      context: context,
      title: error.toString(),
    );
  }

  void _onCreateSuccess(MqHatimModel? data) {
    HatimCrudSuccesView.show(
      context: context,
      title: context.l10n.hatimCreated,
      description: context.l10n.hatimDescription,
    );
  }

  void _onFechedInitialDataError(Object error) {
    AppAlert.showErrorDialog(
      context,
      errorText: context.l10n.initialDataFetchError,
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }

  void _onFechedInitialData(MqHatimModel data) {
    _titleCtl.text = data.title ?? '';
    _descriptionCtl.text = data.description ?? '';
    if (data.participants != null) {
      _participants.value = data.participants!
          .map(
            (e) => MqUserIdModel(
              id: e.user?.id,
              userName: e.user?.userName,
              email: e.user?.email,
              firstName: e.user?.firstName,
              lastName: e.user?.lastName,
              accepted: e.accepted,
            ),
          )
          .toList();
    }
  }

  Future<void> _onNavigateToHatimParticipants() async {
    await HatimParticipantsView.show(
      context: context,
      onAddParticipant: (item) {
        _participants.value = List.from(_participants.value)..add(item);
      },
      onRemoveParticipant: (item) {
        _participants.value = List.from(_participants.value)..remove(item);
      },
      initialParticipants: _participants.value,
    );
    if (mounted) setState(() {});
  }

  void _onDelete() {
    MqBottomSheets.showConfirmSheet<void>(
      context: context,
      title: context.l10n.deleteHatim,
      content: context.l10n.deleteConfirmation,
      cancelText: context.l10n.cancel,
      onCancel: () => Navigator.pop(context),
      confirmButton: BlocProvider.value(
        value: context.read<HatimCrudBloc>(),
        child: BlocConsumer<HatimCrudBloc, HatimCrudState>(
          listener: (context, state) {
            if (state is HatimDeleteSuccess) {
              _onDeleteSuccess();
            } else if (state is HatimDeleteError) {
              _onDeleteError(state.error);
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                final bloc = context.read<HatimCrudBloc>();
                bloc.add(DeleteHatimByIdEvent(bloc.hatimId!));
              },
              child: switch (state) {
                HatimDeleteLoading() => Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                _ => Text(context.l10n.yes),
              },
            );
          },
        ),
      ),
    );
  }
}

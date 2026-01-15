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
    _participants.value.remove(user);
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
      title: 'Hatim deleted',
      description: 'Hatim deleted successfully',
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
      title: 'Hatim updated',
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
      errorText: 'Now can not fetch initial data. Please try again later.',
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
              id: e.id,
              userName: e.user?.userName,
              email: e.user?.email,
              firstName: e.user?.firstName,
              lastName: e.user?.lastName,
            ),
          )
          .toList();
    }
  }
}

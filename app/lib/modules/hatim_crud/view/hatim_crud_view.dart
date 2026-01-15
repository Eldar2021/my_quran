import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

part 'hatim_crud_view_mixin.dart';

class HatimCrudView extends StatelessWidget {
  const HatimCrudView(this.hatimId, {super.key});

  final String? hatimId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HatimCrudBloc(
        repository: context.read<MqHatimRepository>(),
        hatimId: hatimId,
      ),
      child: const HatimCrudViewBody(),
    );
  }
}

class HatimCrudViewBody extends StatefulWidget {
  const HatimCrudViewBody({super.key});

  @override
  State<HatimCrudViewBody> createState() => _HatimCrudViewBodyState();
}

class _HatimCrudViewBodyState extends State<HatimCrudViewBody> with HatimCrudViewMixin {
  @override
  Widget build(BuildContext context) {
    final isUpdate = context.read<HatimCrudBloc>().hatimId != null;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      key: const Key(MqKeys.createHatim),
      appBar: AppBar(
        centerTitle: true,
        title: Text(isUpdate ? 'Update Hatim' : context.l10n.createHatim),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 24),
            FormLabel(context.l10n.title),
            HatimCrudTextField(
              key: const Key(MqKeys.titleTextField),
              controller: _titleCtl,
              validator: (v) => (v == null || v.isEmpty) ? context.l10n.enterHatimTitle : null,
              hintText: context.l10n.enterHatimTitleHere,
              prefixIcon: Assets.icons.title.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 26),
            FormLabel(context.l10n.description),
            HatimCrudTextField(
              key: const Key(MqKeys.descriptionTextField),
              controller: _descriptionCtl,
              maxLines: 5,
              validator: (v) => (v == null || v.isEmpty) ? context.l10n.enterHatimDescription : null,
              hintText: context.l10n.enterHatimDescriptionHere,
              prefixIcon: Assets.icons.fluentDescription.svg(
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 26),
            FormLabel(context.l10n.participants),
            ExcludeFocus(
              child: HatimCrudTextField(
                onTap: () {},
                validator: (_) => _participants.value.isEmpty ? context.l10n.addParticipantsToHatim : null,
                readOnly: true,
                hintText: context.l10n.addParticipantsToYourHatim,
                prefixIcon: Assets.icons.solidUsers.svg(
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                suffixIcon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: colorScheme.inverseSurface,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder(
              valueListenable: _participants,
              builder: (context, value, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final user = value[index];
                    return ParticipantTile(
                      user: user,
                      text: context.l10n.remove,
                      isOutlined: true,
                      onPressed: () => _removeParticipant(user),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocConsumer<HatimCrudBloc, HatimCrudState>(
          listener: (context, state) {
            context.manageLoader(state is HatimFetchedInitialDataLoading);
            if (state is HatimFetchedInitialDataSuccess) {
              _onFechedInitialData(state.data);
            } else if (state is HatimFetchedInitialDataError) {
              _onFechedInitialDataError(state.error);
            } else if (state is HatimCreateSuccess) {
              _onCreateSuccess(state.res);
            } else if (state is HatimCreateError) {
              _onCreateError(state.error);
            } else if (state is HatimUpdateSuccess) {
              _onUpdateSuccess(state.res);
            } else if (state is HatimUpdateError) {
              _onUpdateError(state.error);
            } else if (state is HatimDeleteSuccess) {
              _onDeleteSuccess();
            } else if (state is HatimDeleteError) {
              _onDeleteError(state.error);
            }
          },
          builder: (context, state) {
            final loading = state.isLoading;
            return ElevatedButton(
              key: const Key(MqKeys.createHatimButton),
              onPressed: loading ? null : _onSubmit,
              child: loading
                  ? const SizedBox.square(
                      dimension: 25,
                      child: CircularProgressIndicator(
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
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;
  final FocusNode _searchFocusNode = FocusNode();
  bool _isTooShort = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() => setState(() {}));
    _searchController = TextEditingController()..addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;

    return Scaffold(
      key: const Key(MqKeys.search),
      appBar: AppBar(title: Text(context.l10n.addParticipants), centerTitle: true),
      body: BlocBuilder<CreateHatimCubit, CreateHatimState>(
        builder: (context, state) {
          final status = state.status;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                SearchInputField(searchController: _searchController, searchFocusNode: _searchFocusNode),
                if (_isTooShort)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      context.l10n.queryMinLength,
                      style: prTextTheme.bodySmall?.copyWith(color: AppColors.tomato),
                    ),
                  ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      if (state.selectedUsers.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(context.l10n.addedParticipants, style: prTextTheme.titleMedium),
                        const SizedBox(height: 10),
                        ListView.builder(
                          itemCount: state.selectedUsers.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 10),
                          itemBuilder: (context, index) {
                            final user = state.selectedUsers[index];
                            return ParticipantTile(
                              user: user,
                              text: context.l10n.remove,
                              isOutlined: true,
                              onPressed: () => context.read<CreateHatimCubit>().removeParticipant(user),
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: 20),
                      Text(context.l10n.allUsers, style: prTextTheme.titleMedium),
                      const SizedBox(height: 10),
                      switch (status) {
                        FetchStatus.initial => Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 180),
                            child: Text(context.l10n.searchUser),
                          ),
                        ),
                        FetchStatus.loading => const Center(
                          child: Padding(padding: EdgeInsets.only(top: 180), child: CircularProgressIndicator()),
                        ),
                        FetchStatus.error => const SizedBox.shrink(),

                        FetchStatus.success =>
                          state.searchModel?.users == null || state.searchModel!.users!.isEmpty
                              ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 180),
                                  child: Text(context.l10n.noUsersFound),
                                ),
                              )
                              : ListView.builder(
                                itemCount: state.searchModel!.users!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 120),
                                itemBuilder: (context, index) {
                                  final user = state.searchModel!.users![index];
                                  final isAdded = state.selectedUsers.any((u) => u.id == user.id);
                                  final cubit = context.read<CreateHatimCubit>();

                                  return ParticipantTile(
                                    user: user,
                                    text: context.l10n.add,
                                    onPressed: isAdded ? null : () => cubit.addParticipant(user),
                                  );
                                },
                              ),
                      },
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () {
            final participants = context.read<CreateHatimCubit>().state.selectedUsers;
            context.pop<List<MqUserIdModel>>(participants);
          },
          child: Text(context.l10n.done),
        ),
      ),
    );
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    final len = query.length;
    final cubit = context.read<CreateHatimCubit>();

    if (len == 0) {
      if (_isTooShort) setState(() => _isTooShort = false);
      cubit.clearSearch();
    } else if (len < 3) {
      if (!_isTooShort) setState(() => _isTooShort = true);
      cubit.clearSearch();
    } else {
      if (_isTooShort) setState(() => _isTooShort = false);
      cubit.getSearch(query);
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

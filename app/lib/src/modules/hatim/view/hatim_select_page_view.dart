import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/src/src.dart';


class HatimJusBottomSheet extends StatelessWidget {
  const HatimJusBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(
            context.l10n.hatimPleaseSelectPage,
            key: const Key(MqKeys.hatimSelectPage),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          BlocBuilder<HatimJuzCubit, HatimJuzState>(
            builder: (context, state) {
              return switch (state.status) {
                FetchStatus.loading => const Center(child: CircularProgressIndicator()),
                FetchStatus.success => HatimPageGridLisrBuilder(state.pages ?? []),
                FetchStatus.error => const Center(child: Text('error')),
              };
            },
          ),
          const SizedBox(height: 20),
          ColorTextAppHint(
            color: AppColors.red,
            hintText: context.l10n.hatimDoneReadDesc,
          ),
          const SizedBox(height: 10),
          ColorTextAppHint(
            color: AppColors.yellow,
            hintText: context.l10n.hatimProccessReadDesc,
          ),
          const SizedBox(height: 10),
          ColorTextAppHint(
            color: AppColors.green,
            hintText: context.l10n.hatimEmptyReadDesc,
          ),
          const SizedBox(height: 20),
          Text(
            context.l10n.hatimUserHintSelectEmtyPage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                key: const Key(MqKeys.hatimSelectPageCancel),
                onPressed: () => context.pop(),
                child: Text(context.l10n.cancel),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                key: const Key(MqKeys.hatimSelectPageOk),
                onPressed: () => context.pop(),
                child: Text(context.l10n.select),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HatimPageGridLisrBuilder extends StatelessWidget {
  const HatimPageGridLisrBuilder(this.items, {super.key});

  final List<HatimPages> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: items
          .map(
            (e) => HatimPageStatusCard(
              status: e.status,
              pageNumber: e.number,
              pages: (context.watch<HatimPagesCubit>().state.pages ?? []).map((e) => e?.number).toList(),
              onTap: e.status.isActive
                  ? () {
                      final cubit = context.read<HatimJuzCubit>();
                      final user = context.read<AuthCubit>().state.user!;
                      if (e.status == HatimPageStatus.todo) {
                        cubit.selectPage(e.id, user.accessToken, user.username);
                      } else {
                        cubit.unSelectPage(e.id, user.accessToken, user.username);
                      }
                    }
                  : null,
            ),
          )
          .toList(),
    );
  }
}

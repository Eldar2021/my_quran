import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

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
              if (state.status == FetchStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == FetchStatus.success) {
                return HatimPageGridLisrBuilder(state.pages ?? []);
              } else if (state.status == FetchStatus.error) {
                return const Center(child: Text('error'));
              } else {
                return const Center(child: Text('some'));
              }
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
                onPressed: () => Navigator.pop(context),
                child: Text(context.l10n.cancel),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                key: const Key(MqKeys.hatimSelectPageOk),
                onPressed: () => Navigator.pop(context),
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
      children: items.map((e) => HatimPageStatusCard(hatimPage: e)).toList(),
    );
  }
}

class HatimPageStatusCard extends StatelessWidget {
  const HatimPageStatusCard({required this.hatimPage, super.key});

  final HatimPages hatimPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 55,
      child: InkWell(
        onTap: hatimPage.status == Status.todo || hatimPage.status == Status.booked
            ? () {
                final user = context.read<AuthCubit>().state.user!;
                if (hatimPage.status == Status.todo) {
                  context.read<HatimJuzCubit>().selectPage(hatimPage.id, user.accessToken, user.username);
                } else {
                  context.read<HatimJuzCubit>().unSelectPage(hatimPage.id, user.accessToken, user.username);
                }
              }
            : null,
        child: MaterialCard(
          color: hatimPage.status == Status.done
              ? AppColors.red
              : hatimPage.status == Status.booked || hatimPage.status == Status.inProgress
                  ? AppColors.yellow
                  : AppColors.green,
          text: '${hatimPage.number}',
          textColor: hatimPage.status == Status.done
              ? AppColors.white
              : hatimPage.status == Status.inProgress
                  ? AppColors.black
                  : hatimPage.status == Status.todo
                      ? AppColors.white
                      : AppColors.black,
          check: (context.watch<HatimPagesCubit>().state.pages ?? [])
                  .map((e) => e?.number)
                  .toList()
                  .contains(hatimPage.number)
              ? Positioned(
                  right: 2,
                  top: 2,
                  child: Icon(
                    Icons.check,
                    size: 17,
                    color: hatimPage.status == Status.done ? null : AppColors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

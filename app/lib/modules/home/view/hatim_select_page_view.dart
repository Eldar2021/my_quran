import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/models/models.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/theme/theme.dart';

class HatimSelectPageView extends StatelessWidget {
  const HatimSelectPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: 400,
          child: BlocBuilder<HatimJuzCubit, HatimJuzState>(
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
        ),
        const SizedBox(height: 10),
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
        const Spacer(),
        Expanded(
          child: Text(
            context.l10n.hatimUserHintSelectEmtyPage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class HatimPageGridLisrBuilder extends StatelessWidget {
  const HatimPageGridLisrBuilder(this.items, {super.key});

  final List<HatimPages> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return HatimPageStatusCard(hatimPage: item);
      },
    );
  }
}

class HatimPageStatusCard extends StatelessWidget {
  const HatimPageStatusCard({required this.hatimPage, super.key});

  final HatimPages hatimPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}

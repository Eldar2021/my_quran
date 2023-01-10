import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/components/components.dart';
import 'package:hatim/l10n/l10.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class HatimSelectPageView extends StatelessWidget {
  const HatimSelectPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 15),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.44,
          width: 400,
          child: BlocBuilder<HatimPageCubit, HatimPageState>(
            builder: (context, state) {
              if (state.pages != null) {
                return HatimPageGridLisrBuilder(state.pages!);
              } else {
                return const Center(child: CupertinoAlertDialog());
              }
            },
          ),
        ),
        const SizedBox(height: 15),
        ColorTextAppHint(
          color: colorScheme.primary,
          hintText: context.l10n.hatimDoneReadDesc,
        ),
        const SizedBox(height: 15),
        ColorTextAppHint(
          color: colorScheme.tertiary,
          hintText: context.l10n.hatimProccessReadDesc,
        ),
        const SizedBox(height: 15),
        ColorTextAppHint(
          color: colorScheme.secondary,
          hintText: context.l10n.hatimEmptyReadDesc,
        ),
        const SizedBox(height: 25),
        Text(
          context.l10n.hatimUserHintSelectEmtyPage,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class HatimPageGridLisrBuilder extends StatelessWidget {
  const HatimPageGridLisrBuilder(this.items, {super.key});

  final List<HatimPage> items;

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
  const HatimPageStatusCard({super.key, required this.hatimPage});

  final HatimPage hatimPage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: hatimPage.status == PageStatus.empty ? () {} : null,
      child: MaterialCard(
        color: hatimPage.status == PageStatus.done
            ? colorScheme.primary
            : hatimPage.status == PageStatus.process
                ? colorScheme.tertiary
                : colorScheme.secondary,
        text: '${hatimPage.id}',
        textColor: hatimPage.status == PageStatus.done
            ? colorScheme.onPrimary
            : hatimPage.status == PageStatus.process
                ? colorScheme.onTertiary
                : colorScheme.onSecondary,
        check: hatimPage.isMy
            ? Positioned(
                right: 2,
                top: 2,
                child: Icon(Icons.check, size: 17, color: colorScheme.onPrimary),
              )
            : null,
      ),
    );
  }
}

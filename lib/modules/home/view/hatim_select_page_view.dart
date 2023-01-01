import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/components/components.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class HatimSelectPageView extends StatelessWidget {
  const HatimSelectPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Please select pages',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          BlocBuilder<HatimPageCubit, HatimPageState>(
            builder: (context, state) {
              if (state.pages != null) {
                return HatimPageGridLisrBuilder(state.pages!);
              } else {
                return const Center(child: CupertinoAlertDialog());
              }
            },
          ),
          const SizedBox(height: 15),
          ColorTextAppHint(
            color: colorScheme.primary,
            hintText: 'This is Done color',
          ),
          const SizedBox(height: 15),
          ColorTextAppHint(
            color: colorScheme.tertiary,
            hintText: 'This is Processing color',
          ),
          const SizedBox(height: 15),
          ColorTextAppHint(
            color: colorScheme.secondary,
            hintText: 'This is Empty color',
          ),
          const SizedBox(height: 25),
          const Text(
            'However, as the above widgets use lazy loading/viewport* the size is not determined upfront and an exception is thrown within',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                key: const Key('cancel-button'),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                key: const Key('ok-button'),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HatimPageGridLisrBuilder extends StatelessWidget {
  const HatimPageGridLisrBuilder(this.items, {super.key});

  final List<HatimPage> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
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
      ),
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
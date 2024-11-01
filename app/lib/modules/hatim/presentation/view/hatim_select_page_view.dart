import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/constants/contants.dart';

import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/hatim/hatim.dart';
import 'package:my_quran/modules/modules.dart';

class HatimJusSelectPagesView extends StatelessWidget {
  const HatimJusSelectPagesView({
    required this.hatimJusEntity,
    super.key,
  });

  final HatimJusEntity hatimJusEntity;

  @override
  Widget build(BuildContext context) {
    print('Aidai 2');
    //
    return Scaffold(
      key: const Key(MqKeys.hatimSelectPage),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        title: Text(context.l10n.hatim),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              '${hatimJusEntity.number}-${context.l10n.juz} ${context.l10n.fromThirty}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFCADC),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xffF5F5F5), width: 4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                hatimJusEntity.inProgress.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              Text(
                                context.l10n.pages,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 120,
                          height: 116,
                          decoration: BoxDecoration(
                            color: const Color(0xffF6684E),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xffF5F5F5), width: 4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                hatimJusEntity.toDo.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                context.l10n.pages,
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 100,
                        child: Container(
                          width: 87,
                          height: 85,
                          decoration: BoxDecoration(
                            color: const Color(0xffA851FA),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xffF5F5F5), width: 4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                hatimJusEntity.done.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                context.l10n.pages,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(context.l10n.readed, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 5),
                          Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xffA851FA)),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Color(0xffA851FA),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(context.l10n.reading, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 5),
                          Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xffFFCADC)),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Color(0xffFFCADC),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(context.l10n.notSelected, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 5),
                          Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xffF6684E)),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Color(0xffF6684E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '❝',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1C274C),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    context.l10n.selectUnoccupiedPages,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xff1C274C)),
                  ),
                ),
                const SizedBox(
                  height: 53,
                  child: VerticalDivider(
                    color: Color(0xff1C274C),
                    thickness: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${context.l10n.withRespect}, ',
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff1C274C)),
                ),
                const Text(
                  'MyQuran ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xff1C274C)),
                ),
                Assets.images.emoji.image(height: 47, width: 50),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<HatimBloc, HatimState>(
              builder: (context, state) {
                final juzPagesState = state.juzPagesState;
                return switch (juzPagesState) {
                  HatimJuzPagesInitial() => const Center(child: CircularProgressIndicator()),
                  HatimJuzPagesLoading() => const Center(child: CircularProgressIndicator()),
                  HatimJuzPagesFetched() => HatimPageGridListBuilder(juzPagesState.data),
                  HatimJuzPagesFailed() => Center(child: Text('${juzPagesState.exception}')),
                };
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class HatimPageGridListBuilder extends StatelessWidget {
  const HatimPageGridListBuilder(this.items, {super.key});

  final List<HatimPagesEntity> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromRGBO(0, 0, 0, 0.06),
          width: 0.5,
        ),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(226, 226, 226, 0.35),
            Color.fromRGBO(226, 226, 226, 0.35),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        color: Colors.white.withOpacity(0),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: items.map(
          (e) {
            return HatimPageStatusCard(
              status: e.status,
              pageNumber: e.number,
              isMine: e.mine,
              onTap: e.status.isActive
                  ? () {
                      final bloc = context.read<HatimBloc>();
                      if (e.status == HatimPageStatus.todo) {
                        MqAnalytic.track(
                          AnalyticKey.selectPage,
                          params: {'page': e.id},
                        );
                        bloc.add(SelectPageEvent(e.id));
                      } else if (e.mine) {
                        MqAnalytic.track(
                          AnalyticKey.unselectPage,
                          params: {'page': e.id},
                        );
                        bloc.add(UnSelectPageEvent(e.id));
                      }
                    }
                  : null,
            );
          },
        ).toList(),
      ),
    );
  }
}

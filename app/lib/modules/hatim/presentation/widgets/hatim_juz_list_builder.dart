import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/core/core.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';

class HatimJuzListBuilder extends StatelessWidget {
  const HatimJuzListBuilder(this.items, {super.key});

  final List<HatimJusEntity> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key(MqKeys.hatimJuzsList),
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 70),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                key: Key(MqKeys.hatimJuzIndex(index)),
                contentPadding: const EdgeInsets.all(8),
                title: Text('${item.number}-${context.l10n.juz}'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerticalText(context.l10n.hatimDoneRead, '${item.done}'),
                    VerticalText(context.l10n.hatimProccessRead, '${item.inProgress}'),
                    VerticalText(context.l10n.hatimEmptyRead, '${item.toDo}'),
                  ],
                ),
                onTap: () async {
                  context.read<MqAnalytic>().track(
                    AnalyticKey.hatimSelectJuz,
                    params: {'juzId': item.id},
                  );
                  final bloc = context.read<HatimBloc>();
                  await AppBottomSheet.showBottomSheet<void>(
                    context,
                    scrollKey: const Key(MqKeys.hatimSelectPageScroll),
                    initialChildSize: 0.85,
                    BlocProvider.value(
                      value: bloc..add(GetHatimJuzPagesEvent(item.id)),
                      child: const HatimJusBottomSheet(),
                    ),
                  );

                  bloc.add(const ResetJuzPagesEvent());
                },
              ),
              JuzPersentWidget(item),
            ],
          ),
        );
      },
    );
  }
}

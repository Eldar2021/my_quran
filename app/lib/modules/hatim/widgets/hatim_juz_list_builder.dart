import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class HatimJuzListBuilder extends StatelessWidget {
  const HatimJuzListBuilder(this.items, {super.key});

  final List<MqHatimJusEntity> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key(MqKeys.hatimJuzsList),
      itemCount: items.length,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 70),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: HatimJuzItemCard(
            key: Key(MqKeys.hatimJuzIndex(index)),
            total: '${item.total}',
            title: '${context.l10n.juz} ${index + 1}',
            firstText: context.l10n.readed,
            secondText: context.l10n.reading,
            thirdText: context.l10n.notSelected,
            firstValue: item.done,
            secondValue: item.inProgress,
            thirdValue: item.toDo,
            onTap: () => _onTap(item, context),
          ),
        );
      },
    );
  }

  Future<void> _onTap(MqHatimJusEntity item, BuildContext context) async {
    MqAnalytic.track(AnalyticKey.selectHatimJuz, params: {'juzId': item.id});
    final bloc = context.read<HatimBloc>();
    await Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder:
            (BuildContext context) => BlocProvider.value(
              value: bloc..add(GetHatimJuzPagesEvent(item.id)),
              child: HatimJusSelectPagesView(hatimJusEntity: item),
            ),
      ),
    );
    bloc.add(const ResetJuzPagesEvent());
  }
}

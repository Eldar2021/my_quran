import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';

class JuzAnnotationWidget extends StatelessWidget {
  const JuzAnnotationWidget({
    required this.item,
    super.key,
  });

  final HatimJusEntity item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${item.number}-${context.l10n.juz}',
          style: const TextStyle(
            color: Color(0xff1C274C),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 5),
        ProgressRowWidget(
          count: item.done,
          label: context.l10n.pages,
          color: const Color(0xffA851FA),
        ),
        ProgressRowWidget(
          count: item.inProgress,
          label: context.l10n.pages,
          color: const Color(0xffFFCADC),
        ),
        ProgressRowWidget(
          count: item.toDo,
          label: context.l10n.pages,
          color: const Color(0xffF6684E),
        ),
      ],
    );
  }
}

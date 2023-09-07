import 'package:flutter/material.dart';
import 'package:my_quran/models/hatim/hatim_juz.dart';
import 'package:my_quran/theme/theme.dart';

class JuzPersentWidget extends StatelessWidget {
  const JuzPersentWidget(this.item, {super.key});

  final HatimJus item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        JuzPercent(AppColors.red, percent: item.donePercent),
        JuzPercent(AppColors.yellow, percent: item.inProgressPercent),
        JuzPercent(AppColors.green, percent: item.toDoPercent),
      ],
    );
  }
}

class JuzPercent extends StatelessWidget {
  const JuzPercent(this.color, {required this.percent, super.key});

  final Color color;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      width: ((MediaQuery.of(context).size.width - 44) * percent) / 100,
    );
  }
}

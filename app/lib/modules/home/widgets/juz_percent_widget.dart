import 'package:flutter/material.dart';
import 'package:my_quran/models/hatim/hatim_juz.dart';
import 'package:my_quran/theme/theme.dart';

class JuzPersentWidget extends StatelessWidget {
  const JuzPersentWidget(this.item, {super.key});

  final HatimJus item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(120),
          ),
          height: 4,
          width: ((size.width - 44) * item.donePercent) / 100,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 4,
          width: ((size.width - 44) * item.inProgress) / 100,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 4,
          width: ((size.width - 44) * item.toDoPercent) / 100,
        ),
      ],
    );
  }
}

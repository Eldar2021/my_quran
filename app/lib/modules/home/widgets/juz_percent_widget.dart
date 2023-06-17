import 'package:flutter/material.dart';
import 'package:my_quran/models/hatim/hatim_juz.dart';
import 'package:my_quran/theme/theme.dart';

class JuzPersentWidget extends StatelessWidget {
  const JuzPersentWidget(this.item, {super.key});

  final HatimJus item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 4,
            width: (size.width * item.toDoPercent) / 112,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 4,
            width: (size.width * item.inProgressPercent) / 112,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 4,
            width: (size.width * item.donePercent) / 112,
          ),
        ],
      ),
    );
  }
}

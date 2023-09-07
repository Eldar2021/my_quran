import 'package:flutter/material.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/models/models.dart';
import 'package:my_quran/theme/theme.dart';

class HatimPageStatusCard extends StatelessWidget {
  const HatimPageStatusCard({
    required this.status,
    required this.pageNumber,
    required this.pages,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final Status status;
  final int pageNumber;
  final List<int?> pages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 55,
      child: InkWell(
        onTap: onTap,
        child: MaterialCard(
          color: status == Status.done
              ? AppColors.red
              : status == Status.booked || status == Status.inProgress
                  ? AppColors.yellow
                  : AppColors.green,
          text: '$pageNumber',
          textColor: status == Status.done
              ? AppColors.white
              : status == Status.inProgress
                  ? AppColors.black
                  : status == Status.todo
                      ? AppColors.white
                      : AppColors.black,
          check: pages.contains(pageNumber)
              ? Positioned(
                  right: 2,
                  top: 2,
                  child: Icon(
                    Icons.check,
                    size: 17,
                    color: status == Status.done ? null : AppColors.black,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

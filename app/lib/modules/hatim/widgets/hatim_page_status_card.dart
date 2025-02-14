import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

class HatimPageStatusCard extends StatelessWidget {
  const HatimPageStatusCard({
    required this.status,
    required this.pageNumber,
    required this.isMine,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final HatimPageStatus status;
  final int pageNumber;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      HatimPageStatus.done =>
        isMine
            ? CircleButton(
              backgroundColor: AppColors.tomato2,
              foregroundColor: AppColors.white,
              disabledForegroundColor: AppColors.tomato2,
              borderColor: AppColors.tomato2,
              onPressed: onTap,
              child: Text('$pageNumber'),
            )
            : CircleButton(
              foregroundColor: AppColors.tomato2,
              disabledForegroundColor: AppColors.tomato2,
              borderColor: AppColors.tomato2,
              onPressed: onTap,
              child: Text('$pageNumber'),
            ),
      HatimPageStatus.inProgress || HatimPageStatus.booked =>
        isMine
            ? CircleButton(
              backgroundColor: AppColors.goldenrod,
              foregroundColor: AppColors.white,
              disabledForegroundColor: AppColors.goldenrod,
              borderColor: AppColors.goldenrod,
              onPressed: onTap,
              child: Text('$pageNumber'),
            )
            : CircleButton(
              foregroundColor: AppColors.goldenrod,
              disabledForegroundColor: AppColors.goldenrod,
              borderColor: AppColors.goldenrod,
              onPressed: onTap,
              child: Text('$pageNumber'),
            ),
      HatimPageStatus.todo => CircleButton(
        foregroundColor: AppColors.mediumseagreen,
        disabledForegroundColor: AppColors.mediumseagreen,
        borderColor: AppColors.mediumseagreen,
        onPressed: onTap,
        child: Text('$pageNumber'),
      ),
    };
  }
}

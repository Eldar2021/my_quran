import 'package:flutter/material.dart';

import 'package:my_quran/components/components.dart';
import 'package:my_quran/modules/modules.dart';

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
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: status.bgColor, width: 6),
      ),
      child: InkWell(
        onTap: onTap,
        child: MaterialCard(
          text: '$pageNumber',
          textColor: status.frColor,
          color: Colors.white,
          type: MaterialType.circle,
          check: isMine
              ? Positioned(
                  right: 2,
                  top: 2,
                  child: Icon(Icons.check, size: 17, color: status.iconColor),
                )
              : null,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_quran/app_imports.dart';


class HatimPageStatusCard extends StatelessWidget {
  const HatimPageStatusCard({
    required this.status,
    required this.pageNumber,
    required this.pages,
    this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final HatimPageStatus status;
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
          color: status.bgColor,
          text: '$pageNumber',
          textColor: status.frColor,
          check: pages.contains(pageNumber)
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

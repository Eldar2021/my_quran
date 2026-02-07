import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';

class UserRatingPeriodTypesHeader extends StatelessWidget {
  const UserRatingPeriodTypesHeader({
    required this.selectedPeriod,
    required this.onPeriodChanged,
    super.key,
  });

  final PeriodType selectedPeriod;
  final void Function(PeriodType) onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    return SliverPersistentHeader(
      floating: true,
      delegate: CustomHeaderDelegate(
        minHeight: 70,
        maxHeight: 70,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          scrollDirection: Axis.horizontal,
          itemCount: PeriodType.values.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final period = PeriodType.values[index];
            final isSelected = selectedPeriod == period;
            return ChoiceChip(
              showCheckmark: false,
              selected: isSelected,
              label: Text(
                switch (period) {
                  PeriodType.weekly => 'Weekly',
                  PeriodType.monthly => 'Monthly',
                  PeriodType.threeMonth => 'Three Month',
                  PeriodType.year => 'Year',
                },
              ),
              onSelected: (selected) => onPeriodChanged(period),
              selectedColor: colorScheme.primary,
              labelStyle: prTextTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
      ),
    );
  }
}

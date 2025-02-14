import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class MqBankInfoCard extends StatelessWidget {
  const MqBankInfoCard({
    required this.bankName,
    required this.bankAccount,
    required this.accountName,
    this.copyLabel = 'Copy',
    this.copyText,
    super.key,
  });

  final String bankName;
  final String bankAccount;
  final String accountName;
  final String copyLabel;
  final String? copyText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDark ? colorScheme.outline.withValues(alpha: 0.3) : colorScheme.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(bankName, style: prTextTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(bankAccount, style: prTextTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(accountName, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: copyText ?? bankAccount));
                    },
                    icon: Assets.icons.copy.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
                  ),
                  Text(copyLabel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

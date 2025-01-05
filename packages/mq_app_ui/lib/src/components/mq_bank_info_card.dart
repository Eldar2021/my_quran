import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class MqBankInfoCard extends StatelessWidget {
  const MqBankInfoCard({
    required this.bankName,
    required this.bankAccount,
    this.copyLabel = 'Copy',
    super.key,
  });

  final String bankName;
  final String bankAccount;
  final String copyLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDark ? colorScheme.outline.withOpacity(0.3) : colorScheme.surface,
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
                    Row(
                      children: [
                        Assets.icons.visa.svg(
                          colorFilter: ColorFilter.mode(
                            colorScheme.onSurface,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            bankName,
                            style: prTextTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        bankAccount,
                        style: prTextTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: bankAccount),
                      );
                    },
                    icon: Assets.icons.copy.svg(
                      colorFilter: ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
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

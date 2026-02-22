import 'package:flutter/material.dart';

class QuranBrokenBanner extends StatelessWidget {
  const QuranBrokenBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.error),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(
            "Bu sayfanın özel font yapısında bir hata oluştu. Kur'an'ı doğru okuyabilmeniz için geçici olarak standart Uthmani fontu gösterilmektedir. En kısa sürede düzeltilecektir.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}

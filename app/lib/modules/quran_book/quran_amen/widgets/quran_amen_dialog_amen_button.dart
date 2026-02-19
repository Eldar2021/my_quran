import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_quran/l10n/l10.dart';

class QuranAmenDialogAmenButton extends StatelessWidget {
  const QuranAmenDialogAmenButton({
    required this.onAmen,
    this.isloading = false,
    super.key,
  });

  final void Function()? onAmen;
  final bool isloading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAmen,
      style: ElevatedButton.styleFrom(fixedSize: const Size(double.maxFinite, 52)),
      child: isloading ? const CupertinoActivityIndicator() : Text(context.l10n.ameen),
    );
  }
}

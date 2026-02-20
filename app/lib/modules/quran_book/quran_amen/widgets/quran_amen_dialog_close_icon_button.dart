import 'package:flutter/material.dart';

class QuranAmenDialogCloseIconButton extends StatelessWidget {
  const QuranAmenDialogCloseIconButton({
    this.color,
    this.onPressed,
    super.key,
  });

  final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 2, left: 4),
      child: IconButton(
        icon: Icon(Icons.close, color: Colors.transparent),
        onPressed: null,
      ),
    );
  }
}

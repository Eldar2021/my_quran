import 'package:flutter/material.dart';

final class MqPopupActions {
  MqPopupActions(this.key);
  final GlobalKey key;
  void showPopupMenu(BuildContext context) {
    final renderBox = key.currentContext!.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: offset.dy + size.height,
              left: offset.dx + size.width / 2 - 100,
              child: Material(
                color: Colors.transparent,
                child: ClipPath(
                  clipper: BubbleClipper(),
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.play_arrow, color: Colors.black),
                        VerticalDivider(color: Colors.grey),
                        Icon(Icons.translate, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(Rect.fromLTRB(0, 10, size.width, size.height), const Radius.circular(16)))
      ..moveTo(size.width / 2 - 10, 10)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width / 2 + 10, 10)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

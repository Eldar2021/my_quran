import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.child,
    this.backgroundColor,
    this.nipSize = 4.0,
    this.radius = 16.0,
    this.padding = const EdgeInsets.fromLTRB(20, 16, 16, 16),
    super.key,
  });

  final Widget child;
  final double nipSize;
  final double radius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(
        color: backgroundColor ?? Theme.of(context).colorScheme.surfaceBright,
        nipSize: nipSize,
        radius: radius,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  _BubblePainter({
    required this.color,
    required this.nipSize,
    required this.radius,
  });

  final Color color;
  final double nipSize;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(nipSize + radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(
        Offset(size.width, radius),
        radius: Radius.circular(radius),
      )
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(
        Offset(size.width - radius, size.height),
        radius: Radius.circular(radius),
      )
      ..lineTo(nipSize + radius, size.height)
      ..arcToPoint(
        Offset(nipSize, size.height - radius),
        radius: Radius.circular(radius),
      )
      ..lineTo(nipSize, nipSize + 6)
      ..lineTo(-8, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

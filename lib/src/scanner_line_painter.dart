import 'package:flutter/material.dart';

class ScanningLinePainter extends CustomPainter {
  ScanningLinePainter({
    required this.animationValue,
    this.animationColor = Colors.green,
  });
  final double animationValue;
  final Color? animationColor;

  @override
  void paint(Canvas canvas, Size size) {
    final overlayRect = Rect.fromLTWH(
      size.width * 0.1,
      size.height * 0.3,
      size.width * 0.8,
      size.height * 0.4,
    );

    final roundedRect = RRect.fromRectAndRadius(
      overlayRect,
      const Radius.circular(16),
    );

    // Calculate scanning line position
    final lineY = roundedRect.top + animationValue * roundedRect.height;

    // Draw scanning line
    final linePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          animationColor!.withValues(alpha: 0),
          animationColor!.withValues(alpha: 0.5),
          animationColor!.withValues(alpha: 0),
        ],
        // begin: Alignment.centerLeft,
        // end: Alignment.centerRight,
      ).createShader(
        Rect.fromLTWH(roundedRect.left, lineY - 1, roundedRect.width, 2),
      );

    canvas.drawRect(
      Rect.fromLTWH(roundedRect.left, lineY - 2, roundedRect.width, 4),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

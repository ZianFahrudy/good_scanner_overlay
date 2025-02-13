// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ScanningLinePainter extends CustomPainter {
  ScanningLinePainter({
    required this.animationValue,
    this.animationColor = Colors.green,
    this.lineThickness = 4.0, // Custom thickness
  });

  final double animationValue;
  final Color? animationColor;
  final double lineThickness; // Variabel baru untuk ketebalan garis

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
          animationColor!.withOpacity(0),
          animationColor!.withOpacity(0.5),
          animationColor!.withOpacity(0),
        ],
      ).createShader(
        Rect.fromLTWH(roundedRect.left, lineY - lineThickness / 2,
            roundedRect.width, lineThickness),
      );

    canvas.drawRect(
      Rect.fromLTWH(roundedRect.left, lineY - lineThickness / 2,
          roundedRect.width, lineThickness),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

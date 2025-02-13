import 'package:flutter/material.dart';

class ScannerCornerPainter extends CustomPainter {
  ScannerCornerPainter({
    this.borderColor = Colors.green,
    this.cornerRadius = 10.0,
  });

  final Color? borderColor;
  final double cornerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final double overlayWidth = size.width * 0.8;
    final double overlayHeight = size.height * 0.4;
    final double overlayLeft = (size.width - overlayWidth) / 2;
    final double overlayTop = size.height * 0.3;
    final double cornerLength = 60.0; // Panjang border sudut

    final Paint borderPaint = Paint()
      ..color = borderColor ?? Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    // Sudut-sudut overlay
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(overlayLeft, overlayTop, overlayWidth, overlayHeight),
      Radius.circular(cornerRadius),
    );

    final Path path = Path()
      ..moveTo(rrect.left, rrect.top + cornerLength)
      ..lineTo(rrect.left, rrect.top + cornerRadius)
      ..arcToPoint(
        Offset(rrect.left + cornerRadius, rrect.top),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(rrect.left + cornerLength, rrect.top)
      // Garis sudut kanan atas
      ..moveTo(rrect.right - cornerLength, rrect.top)
      ..lineTo(rrect.right - cornerRadius, rrect.top)
      ..arcToPoint(
        Offset(rrect.right, rrect.top + cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(rrect.right, rrect.top + cornerLength)
      // Garis sudut kiri bawah
      ..moveTo(rrect.left, rrect.bottom - cornerLength)
      ..lineTo(rrect.left, rrect.bottom - cornerRadius)
      ..arcToPoint(
        Offset(rrect.left + cornerRadius, rrect.bottom),
        radius: Radius.circular(cornerRadius),
        clockwise: false,
      )
      ..lineTo(rrect.left + cornerLength, rrect.bottom)
      // Garis sudut kanan bawah
      ..moveTo(rrect.right - cornerLength, rrect.bottom)
      ..lineTo(rrect.right - cornerRadius, rrect.bottom)
      ..arcToPoint(
        Offset(rrect.right, rrect.bottom - cornerRadius),
        radius: Radius.circular(cornerRadius),
        clockwise: false,
      )
      ..lineTo(rrect.right, rrect.bottom - cornerLength);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ScannerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double overlayWidth = size.width * 0.8;
    final double overlayHeight = size.height * 0.4;
    final double overlayLeft = (size.width - overlayWidth) / 2;
    final double overlayTop = size.height * 0.3;

    final Rect overlayRect =
        Rect.fromLTWH(overlayLeft, overlayTop, overlayWidth, overlayHeight);
    final RRect roundedRect = RRect.fromRectAndRadius(
      overlayRect,
      Radius.circular(16),
    );

    final Paint borderPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawRRect(roundedRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// // Painter untuk Border Hanya di Sudut
// class ScannerCornerPainter extends CustomPainter {
//   ScannerCornerPainter({this.borderColor = Colors.green});
//   final Color? borderColor;
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double overlayWidth = size.width * 0.8;
//     final double overlayHeight = size.height * 0.4;
//     final double overlayLeft = (size.width - overlayWidth) / 2;
//     final double overlayTop = size.height * 0.3;
//     final double cornerLength = 60.0; // Panjang border sudut

//     final Paint borderPaint = Paint()
//       ..color = borderColor ?? Colors.green
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 6.0;

//     // Sudut-sudut overlay
//     final Offset topLeft = Offset(overlayLeft, overlayTop);
//     final Offset topRight = Offset(overlayLeft + overlayWidth, overlayTop);
//     final Offset bottomLeft = Offset(overlayLeft, overlayTop + overlayHeight);
//     final Offset bottomRight =
//         Offset(overlayLeft + overlayWidth, overlayTop + overlayHeight);

//     final Path path = Path();

//     // Garis sudut kiri atas
//     path.moveTo(topLeft.dx, topLeft.dy + cornerLength);
//     path.lineTo(topLeft.dx, topLeft.dy);
//     path.lineTo(topLeft.dx + cornerLength, topLeft.dy);

//     // Garis sudut kanan atas
//     path.moveTo(topRight.dx - cornerLength, topRight.dy);
//     path.lineTo(topRight.dx, topRight.dy);
//     path.lineTo(topRight.dx, topRight.dy + cornerLength);

//     // Garis sudut kiri bawah
//     path.moveTo(bottomLeft.dx, bottomLeft.dy - cornerLength);
//     path.lineTo(bottomLeft.dx, bottomLeft.dy);
//     path.lineTo(bottomLeft.dx + cornerLength, bottomLeft.dy);

//     // Garis sudut kanan bawah
//     path.moveTo(bottomRight.dx - cornerLength, bottomRight.dy);
//     path.lineTo(bottomRight.dx, bottomRight.dy);
//     path.lineTo(bottomRight.dx, bottomRight.dy - cornerLength);

//     canvas.drawPath(path, borderPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

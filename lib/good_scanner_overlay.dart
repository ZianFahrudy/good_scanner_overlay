import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:good_scanner_overlay/src/overlay_clipper.dart';
import 'package:good_scanner_overlay/src/scanner_line_painter.dart';

enum GoodScannerAnimation { center, fullWidth, none }

enum GoodScannerOverlayBackground { center, none }

enum GoodScannerBorder { center, none }

class GoodScannerOverlay extends StatefulWidget {
  const GoodScannerOverlay({
    super.key,
    this.animationColor = Colors.green,
    this.borderColor = Colors.green,
    this.backgroundBlurColor,
    this.borderRadius,
    this.goodScannerAnimation = GoodScannerAnimation.center,
    this.goodScannerOverlayBackground = GoodScannerOverlayBackground.center,
    this.goodScannerBorder = GoodScannerBorder.none,
  });

  final Color? animationColor;
  final Color? borderColor;
  final Color? backgroundBlurColor;
  final double? borderRadius;
  final GoodScannerAnimation goodScannerAnimation;
  final GoodScannerOverlayBackground goodScannerOverlayBackground;
  final GoodScannerBorder goodScannerBorder;

  @override
  State<GoodScannerOverlay> createState() => _GoodScannerOverlayState();
}

class _GoodScannerOverlayState extends State<GoodScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    _animation = Tween<double>(
            begin: 0,
            end: widget.goodScannerAnimation == GoodScannerAnimation.center
                ? 1
                : screenHeight - 100)
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    return SafeArea(
      child: Stack(
        children: [
          if (widget.goodScannerOverlayBackground ==
              GoodScannerOverlayBackground.center)
            Positioned.fill(
              child: ClipPath(
                clipper: OverlayClipper(
                  borderRadius: widget.borderRadius,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    color: widget.backgroundBlurColor ??
                        Colors.black.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          if (widget.goodScannerBorder == GoodScannerBorder.center)
            Positioned.fill(
              child: CustomPaint(
                painter: ScannerCornerPainter(
                  borderColor: widget.borderColor,
                ),
              ),
            ),
          if (widget.goodScannerAnimation == GoodScannerAnimation.fullWidth)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: _animation.value,
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: _controller.status == AnimationStatus.forward
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        end: _controller.status == AnimationStatus.forward
                            ? Alignment.bottomCenter
                            : Alignment.topCenter,
                        colors: [
                          widget.animationColor!.withValues(alpha: 0.0),
                          widget.animationColor!,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Container(
                      width: screenWidth,
                      height: 20,
                      color: widget.animationColor!,
                    ),
                  ),
                );
              },
            )
          else if (widget.goodScannerAnimation == GoodScannerAnimation.center)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ScanningLinePainter(
                      animationValue: _animation.value,
                      animationColor: widget.animationColor,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
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

// Painter untuk Border Hanya di Sudut
class ScannerCornerPainter extends CustomPainter {
  ScannerCornerPainter({this.borderColor = Colors.green});
  final Color? borderColor;
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
    final Offset topLeft = Offset(overlayLeft, overlayTop);
    final Offset topRight = Offset(overlayLeft + overlayWidth, overlayTop);
    final Offset bottomLeft = Offset(overlayLeft, overlayTop + overlayHeight);
    final Offset bottomRight =
        Offset(overlayLeft + overlayWidth, overlayTop + overlayHeight);

    final Path path = Path();

    // Garis sudut kiri atas
    path.moveTo(topLeft.dx, topLeft.dy + cornerLength);
    path.lineTo(topLeft.dx, topLeft.dy);
    path.lineTo(topLeft.dx + cornerLength, topLeft.dy);

    // Garis sudut kanan atas
    path.moveTo(topRight.dx - cornerLength, topRight.dy);
    path.lineTo(topRight.dx, topRight.dy);
    path.lineTo(topRight.dx, topRight.dy + cornerLength);

    // Garis sudut kiri bawah
    path.moveTo(bottomLeft.dx, bottomLeft.dy - cornerLength);
    path.lineTo(bottomLeft.dx, bottomLeft.dy);
    path.lineTo(bottomLeft.dx + cornerLength, bottomLeft.dy);

    // Garis sudut kanan bawah
    path.moveTo(bottomRight.dx - cornerLength, bottomRight.dy);
    path.lineTo(bottomRight.dx, bottomRight.dy);
    path.lineTo(bottomRight.dx, bottomRight.dy - cornerLength);

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

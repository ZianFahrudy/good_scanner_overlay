import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:good_scanner_overlay/src/overlay_clipper.dart';
import 'package:good_scanner_overlay/src/scanner_line_painter.dart';

class GoodScannerOverlay extends StatefulWidget {
  const GoodScannerOverlay({
    super.key,
    this.animationColor = Colors.green,
    this.backgroundBlurColor,
    this.borderRadius,
  });

  final Color? animationColor;
  final Color? backgroundBlurColor;
  final double? borderRadius;

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
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
    );
  }
}

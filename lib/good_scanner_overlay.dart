// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:good_scanner_overlay/src/overlay_clipper.dart';
import 'package:good_scanner_overlay/src/scanner_border_painter.dart';
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
    this.cornerRadius,
    this.goodScannerAnimation = GoodScannerAnimation.center,
    this.goodScannerOverlayBackground = GoodScannerOverlayBackground.center,
    this.goodScannerBorder = GoodScannerBorder.none,
    this.curve,
    this.backgroudWidget,
    this.lineThickness,
  });

  final Color? animationColor;
  final Color? borderColor;
  final Color? backgroundBlurColor;
  final double? borderRadius;
  final double? cornerRadius;
  final GoodScannerAnimation goodScannerAnimation;
  final GoodScannerOverlayBackground goodScannerOverlayBackground;
  final GoodScannerBorder goodScannerBorder;
  final Cubic? curve;
  final Widget? backgroudWidget;
  final double? lineThickness;

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
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? Curves.linear,
      ),
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
                  child: widget.backgroudWidget ??
                      Container(
                        color: widget.backgroundBlurColor ??
                            Colors.black.withOpacity(0.5),
                      ),
                ),
              ),
            ),
          if (widget.goodScannerBorder == GoodScannerBorder.center)
            Positioned.fill(
              child: CustomPaint(
                painter: ScannerCornerPainter(
                  cornerRadius: widget.cornerRadius ?? 0,
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
                          widget.animationColor!.withOpacity(0.0),
                          widget.animationColor!,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      width: screenWidth,
                      height: widget.lineThickness ?? 50,
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
                      lineThickness: widget.lineThickness ?? 4,
                      // animationColor: widget.animationColor,
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../constants/app_constants.dart';
import 'custom_slider_thumb.dart';
import 'custom_slider_track_shape_painter.dart';

class ThermoPainter extends CustomPainter {
  final double temperature;

  final double animation;

  ThermoPainter(this.temperature, {required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    //container
    final topLeft = Offset(
      (size.width - thermoWidth) / 2 + thickness,
      vPadding + thickness,
    );
    final bottomRight = Offset(
      (size.width + thermoWidth) / 2 - thickness,
      size.height - vPadding - thickness,
    );

    _drawLiquid(
      canvas,
      size,
      bottomRight,
      topLeft,
      offset: const Offset(25, 25),
      blur: true,
    );

    drawContainer(canvas, topLeft, bottomRight);

    _drawRules(size, canvas, temperature / maxTemperature);

    // mask
    _drawMask(canvas, size);

    _drawLiquid(canvas, size, bottomRight, topLeft);

    // white border
    _drawContainerBorder(canvas, topLeft, bottomRight);

    // reflets
    _drawReflections(size, canvas);
  }

  void _drawContainerBorder(
      ui.Canvas canvas, ui.Offset topLeft, ui.Offset bottomRight) {
    return canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(topLeft, bottomRight),
        const Radius.circular(thermoWidth),
      ),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12,
    );
  }

  void _drawMask(ui.Canvas canvas, ui.Size size) {
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(
              (size.width - thermoWidth) / 2 + thickness, vPadding + thickness),
          Offset((size.width + thermoWidth) / 2 - thickness,
              size.height - vPadding - thickness),
        ),
        const Radius.circular(48),
      ),
    );
  }

  void _drawReflections(ui.Size size, ui.Canvas canvas) {
    var refletTopLeft1 = Offset(
      size.width / 2,
      vPadding + thickness + 30,
    );
    var refletBottomRight1 = Offset(
      size.width / 2 + 28,
      size.height - vPadding - thickness - 30,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(refletTopLeft1, refletBottomRight1),
        const Radius.circular(18),
      ),
      Paint()
        ..shader = ui.Gradient.linear(
          refletTopLeft1,
          refletTopLeft1 + const Offset(30, 0),
          [Colors.white10, Colors.white],
          [0, 1],
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    var refletTopLeft2 = Offset(
      size.width / 2 - 30,
      vPadding + thickness + 30,
    );
    var refletBottomRight2 = Offset(
      size.width / 2 - 12,
      size.height - vPadding - thickness - 30,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(refletTopLeft2, refletBottomRight2),
        const Radius.circular(8),
      ),
      Paint()
        ..shader = ui.Gradient.linear(
          refletTopLeft2,
          refletTopLeft2 + const Offset(20, 0),
          [Colors.white10, Colors.white70],
          [0, 1],
        )
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
  }

  void _drawLiquid(
      ui.Canvas canvas,
      ui.Size size,
      ui.Offset bottomRight,
      ui.Offset topLeft, {
        ui.Offset offset = Offset.zero,
        bool blur = false,
      }) {
    const gradientColors = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.lightGreen,
      Colors.cyan,
    ];

    final lightColors = gradientColors.map((e) => e.withOpacity(.5)).toList();

    // liquid back
    final liquidTopLeft = Offset(
      (size.width - thermoWidth) / 2 + thickness,
      (size.height - radius - vPadding) -
          ((temperature / 50) *
              (size.height - (2 * vPadding + radius * 2))),
    ) -
        offset;

    final r = Rect.fromPoints(liquidTopLeft, bottomRight - offset);
    final colorStops = List.generate(
      gradientColors.length,
          (index) => index / gradientColors.length,
    );

    final pathLight = Path()
      ..moveTo(r.topLeft.dx, r.topLeft.dy - (30 * (1 - animation)))
      ..quadraticBezierTo(
        r.topRight.dx - radius,
        r.topRight.dy - (50 * (animation)),
        r.topRight.dx,
        r.topRight.dy - (30 * (animation)),
      )
      ..lineTo(r.bottomRight.dx, r.bottomRight.dy)
      ..lineTo(r.bottomLeft.dx, r.bottomLeft.dy);

    canvas.drawPath(
      pathLight,
      Paint()
        ..shader = ui.Gradient.linear(
          topLeft,
          bottomRight,
          lightColors,
          colorStops,
        )
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur ? 20 : 0),
    );

    // liquid
    if (!blur) {
      final path = Path()
        ..moveTo(r.topLeft.dx, r.topLeft.dy - (30 * animation))
        ..quadraticBezierTo(
          r.topRight.dx - radius,
          r.topRight.dy,
          r.topRight.dx,
          r.topRight.dy - (30 * (1 - animation)),
        )
        ..lineTo(r.bottomRight.dx, r.bottomRight.dy)
        ..lineTo(r.bottomLeft.dx, r.bottomLeft.dy);
      canvas.drawPath(
        path,
        Paint()
          ..shader = ui.Gradient.linear(
            topLeft,
            bottomRight,
            gradientColors,
            colorStops,
          ),
      );
    }
  }

  void _drawRules(ui.Size size, ui.Canvas canvas, double ratio) {
    final steps = List.generate(20, (index) => index);

    for (final step in steps.skip(2)) {
      final y = step * (size.height - 40) / 20;
      canvas.drawLine(
        Offset(340, y),
        Offset(348, y),
        Paint()
          ..color = y < (1 - ratio) * size.height
              ? Colors.grey.shade300
              : Colors.grey.shade400
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
    }
  }

  void drawContainer(
      ui.Canvas canvas, ui.Offset topLeft, ui.Offset bottomRight) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(topLeft, bottomRight),
        const Radius.circular(48),
      ),
      Paint()..color = Colors.grey.shade300,
    );
  }

  @override
  bool shouldRepaint(covariant ThermoPainter oldDelegate) {
    return oldDelegate.temperature != temperature ||
        oldDelegate.animation != animation;
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onValueChanged;

  const CustomSlider({
    required this.value,
    required this.onValueChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final refHeight = constraints.maxHeight - thumbSize * 1.8;
        var ratio = 1 - value / maxTemperature;

        final trackTop = refHeight * ratio;

        final color = tween.transform(ratio)!;

        return Stack(
          children: [
            Positioned.fill(
              top: 25,
              child: CustomPaint(
                painter: CustomSliderTrackShapePainter(
                  value: ratio,
                  color: color,
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: ui.clampDouble(trackTop, 30, refHeight /*- thumbSize*/),
              child: CustomSliderThumb(
                refHeight: refHeight,
                trackTop: trackTop,
                onValueChanged: onValueChanged,
                color: color,
              ),
            ),
          ],
        );
      },
    );
  }
}
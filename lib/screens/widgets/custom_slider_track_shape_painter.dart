import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../constants/app_constants.dart';

class CustomSliderTrackShapePainter extends CustomPainter {
  final double value;

  final Color color;

  CustomSliderTrackShapePainter({required this.value, required this.color});

  final thickness = 4.0;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    const marginRight = 24.0;

    var refHeight =
    (size.height - thumbSize + ((value - .35) * 14) - (value + .1) * 30);

    final path = Path()
      ..moveTo(marginRight, 0)
      ..lineTo(marginRight, refHeight * (value) - 60)
      ..cubicTo(
        marginRight,
        refHeight * (value) - 20,
        marginRight / 3,
        refHeight * (value) - 40,
        0,
        max(
          thumbSize / 2 + 10,
          refHeight * (value),
        ),
      )
      ..cubicTo(
        0,
        max(80, refHeight * (value) + 40),
        marginRight,
        max(60, refHeight * (value) + 30),
        marginRight,
        max(100, refHeight * (value) + 60),
      )
      ..lineTo(marginRight, size.height) /*..lineTo(marginRight, 0)*/;

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..shader = ui.Gradient.linear(
          const Offset(0, 0),
          Offset(0, size.height),
          [Colors.grey.shade300.withOpacity(0), color, color.withOpacity(0)],
          [0, ui.clampDouble(value, .1, .9), 1],
        ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

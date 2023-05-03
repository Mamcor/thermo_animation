import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../constants/app_constants.dart';

class CustomSliderThumb extends StatefulWidget {
  const CustomSliderThumb({
    super.key,
    required this.refHeight,
    required this.trackTop,
    required this.onValueChanged,
    required this.color,
  });

  final double refHeight;
  final double trackTop;
  final ValueChanged<double> onValueChanged;
  final ui.Color color;

  @override
  State<CustomSliderThumb> createState() => _CustomSliderThumbState();
}

class _CustomSliderThumbState extends State<CustomSliderThumb> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (d) => setState(() => active = true),
      onVerticalDragEnd: (d) => setState(() => active = false),
      onVerticalDragUpdate: (d) {
        final newValue = (widget.refHeight - widget.trackTop - d.delta.dy) /
            widget.refHeight *
            maxTemperature;
        widget.onValueChanged(ui.clampDouble(newValue, 0, 50));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: thumbSize,
        height: thumbSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.white70,
              active ? widget.color : Colors.grey.shade300,
            ],
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 0),
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.grey.shade400,
              blurStyle: BlurStyle.inner,
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const thumbSize = 52.0;
const minTemperature = 0.0;
const maxTemperature = 50.0;

const thermoWidth = 96.0;
const vPadding = 20.0;
const thickness = 8.0;
const radius = thermoWidth / 2;

final tween = TweenSequence<Color?>(
  [
    TweenSequenceItem(
      tween: ColorTween(begin: Colors.red, end: Colors.orange).chain(
          CurveTween(curve: const Interval(0.0, 0.15, curve: Curves.linear))),
      weight: 0.25,
    ),
    TweenSequenceItem(
      tween: ColorTween(begin: Colors.orange, end: Colors.amber).chain(
          CurveTween(curve: const Interval(0.15, 0.3, curve: Curves.linear))),
      weight: 0.25,
    ),
    TweenSequenceItem(
      tween: ColorTween(begin: Colors.amber, end: Colors.lightGreen).chain(
          CurveTween(curve: const Interval(0.3, 0.5, curve: Curves.linear))),
      weight: 0.25,
    ),
    TweenSequenceItem(
      tween: ColorTween(begin: Colors.lightGreen, end: Colors.cyan).chain(
          CurveTween(curve: const Interval(0.5, .7, curve: Curves.linear))),
      weight: 0.25,
    ),
  ],
);

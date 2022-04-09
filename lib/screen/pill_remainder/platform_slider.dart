import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PlatformSlider extends StatelessWidget {
  final int min, max, divisions, value;
  final Function handler;
  final Color color;

  PlatformSlider(
      {required this.value,
      required this.handler,
      required this.color,
      required this.max,
      required this.min,
      required this.divisions});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoSlider(
            max: max.toDouble(),
            onChanged: (value) => handler(value),
            divisions: divisions,
            activeColor: Theme.of(context).primaryColor,
            min: min.toDouble(),
            value: value.toDouble(),
          )
        : Slider(
            onChanged: (value) => handler(value),
            max: max.toDouble(),
            divisions: divisions,
            value: value.toDouble(),
            min: min.toDouble(),
            activeColor: color,
          );
  }
}

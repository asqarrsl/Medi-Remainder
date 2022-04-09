import 'package:flutter/material.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/pill_remainder/platform_slider.dart';

class UserSlider extends StatelessWidget {
  
  final Function handler;
  final int noOfWeeks;

  UserSlider(this.handler, this.noOfWeeks);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PlatformSlider(
          divisions: 11,
          min: 1,
          max: 24,
          value: noOfWeeks,
          color: MyTheme.accent_color,
          handler: handler,
        )),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medi_remainder/models/pill_remainder/medicine_type.dart';
import 'package:medi_remainder/my_theme.dart';

class MedicineTypeCard extends StatelessWidget {
  final MedicineType pillType;
  final Function handler;
  
  MedicineTypeCard(this.pillType, this.handler);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => handler(pillType),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: pillType.isChoose ? MyTheme.accent_color : Colors.white,
            ),
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(width: 50, height: 50.0, child: pillType.image),
                const SizedBox(
                  height: 7.0,
                ),
                Text(
                  pillType.name,
                  style: TextStyle(
                  color: pillType.isChoose ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 15.0,
        )
      ],
    );
  }
}

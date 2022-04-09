import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medi_remainder/models/pill_remainder/pill.dart';
import 'package:medi_remainder/screen/pill_remainder/medicine_card.dart';

class MedicinesList extends StatelessWidget {
  final Function setData;
  final List<Pill> MedicineList;
  final FlutterLocalNotificationsPlugin flutterLocalNotiPlugin;

  MedicinesList(
      this.MedicineList, this.setData, this.flutterLocalNotiPlugin);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => MedicineCard(
          MedicineList[index], setData, flutterLocalNotiPlugin),
      itemCount: MedicineList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

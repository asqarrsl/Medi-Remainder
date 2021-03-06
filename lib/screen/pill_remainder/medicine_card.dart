import 'package:flutter/material.dart';
import 'package:medi_remainder/database/pill_remainder/repository.dart';
import 'package:medi_remainder/models/pill_remainder/pill.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/notifications/pill_remainder/notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MedicineCard extends StatelessWidget {
  final Pill medicine;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MedicineCard(
      this.medicine, this.setData, this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > medicine.time!;

    return Card(
        elevation: 2.0,
        margin: EdgeInsets.symmetric(vertical: 7.0),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onLongPress: () => _showDeleteDialog(
                context, medicine.name!, medicine.id!, medicine.notifyId!),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            title: Text(
              medicine.name!,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${medicine.amount} ${medicine.medicineType}",
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(medicine.time!)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                ),
              ],
            ),
            leading: SizedBox(
              width: 60.0,
              height: 60.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isEnd ? Colors.white : Colors.transparent,
                        BlendMode.saturation),
                    child: Image.asset(medicine.image)),
              ),
            )));
  }

  void _showDeleteDialog(
      BuildContext context, String medicineName, int medicineId, int notifyId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete ?"),
              content: Text("Are you sure to delete $medicineName medicine?"),
              contentTextStyle:
                  TextStyle(fontSize: 17.0, color: Colors.grey[800]),
              actions: [
                FlatButton(
                  splashColor: MyTheme.accent_color.withOpacity(0.3),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: MyTheme.accent_color),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  splashColor: MyTheme.accent_color.withOpacity(0.3),
                  child: Text("Delete",
                      style: TextStyle(color: MyTheme.accent_color)),
                  onPressed: () async {
                    await Repository().delete('PillRemainder', medicineId);
                    await Notifications().removeNotification(
                        notifyId, flutterLocalNotificationsPlugin);
                    setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}

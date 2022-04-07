import 'package:intl/intl.dart';

class CalendarDayModel {
  bool? isChecked;
  int? month;
  int? dayNumber;
  int? year;
  String? dayLetter;

  CalendarDayModel(
      {this.dayLetter, this.dayNumber, this.year, this.month, this.isChecked});

  List<CalendarDayModel> getCurrentDays() {
    DateTime currentTime = DateTime.now();
    final List<CalendarDayModel> daysList = [];
    for (int i = 0; i < 7; i++) {
      daysList.add(CalendarDayModel(
          dayLetter: DateFormat.E().format(currentTime).toString()[0],
          dayNumber: currentTime.day,
          month: currentTime.month,
          year: currentTime.year,
          isChecked: false));
      currentTime = currentTime.add(const Duration(days: 1));
    }
    daysList[0].isChecked = true;
    return daysList;
  }
}

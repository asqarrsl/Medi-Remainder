import 'package:medi_remainder/database/pill_remainder/repository.dart';
import 'package:medi_remainder/models/pill_remainder/calendar_day_model.dart';
import 'package:medi_remainder/models/pill_remainder/pill.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/notifications/pill_remainder/notifications.dart';
import 'package:medi_remainder/screen/pill_remainder/calendar.dart';
import 'package:medi_remainder/screen/pill_remainder/medicines_list.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CalendarEx extends StatefulWidget {
  CalendarEx({Key? key, this.title, this.showBackButton = false})
      : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  _CalendarExState createState() => _CalendarExState();
}

class _CalendarExState extends State<CalendarEx> {
  final Notifications _notifications = Notifications();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //fetch and list all pills from database
  List<Pill> allListOfPills = <Pill>[];
  final Repository _repository = Repository();
  List<Pill> dailyPills = <Pill>[];

  //Calendar days
  final CalendarDayModel _days = CalendarDayModel();
  List<CalendarDayModel>? _daysList;

  //handle last choose day index in calendar
  int _lastChooseDay = 0;

  @override
  void initState() {
    super.initState();
    initNotification();
    getAllData();

    _daysList = _days.getCurrentDays();
  }

  //init notifications
  Future initNotification() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotification(context);

  //fetch all data from database
  Future getAllData() async {
    allListOfPills.clear();
    (await _repository.fetchAllData("PillRemainder"))!.forEach((pillMap) {
      allListOfPills.add(Pill().pillMapToObject(pillMap));
    });
    selectDay(_daysList![_lastChooseDay]);
  }

  void selectDay(CalendarDayModel clickedDay) {
    setState(() {
      _lastChooseDay = _daysList!.indexOf(clickedDay);
      for (var day in _daysList!) {
        day.isChecked = false;
      }
      CalendarDayModel selectDay = _daysList![_daysList!.indexOf(clickedDay)];
      selectDay.isChecked = true;
      dailyPills.clear();
      allListOfPills.forEach((pill) {
        DateTime pillDate =
            DateTime.fromMicrosecondsSinceEpoch(pill.time! * 1000);
        if (selectDay.dayNumber == pillDate.day &&
            selectDay.month == pillDate.month &&
            selectDay.year == pillDate.year) {
          dailyPills.add(pill);
        }
      });
      dailyPills.sort((pill1, pill2) => pill1.time!.compareTo(pill2.time!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    // final double deviceHeight =
    // MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: buildAppBar(statusBarHeight, context),
      backgroundColor: MyTheme.bg_color,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Calendar(selectDay, _daysList!),
                ),
                SizedBox(height: deviceHeight * 0.01),
                dailyPills.isEmpty
                    ? SizedBox(
                        // width: deviceWidth,
                        height: 400,
                        child: OverflowBox(
                          maxHeight: 700,
                          maxWidth: 600,
                          child: Lottie.asset(
                            'assets/lottieanim/nodata_anim.json',
                            repeat: true,
                            reverse: true,
                            alignment: Alignment.center,
                            // width: 50.0,
                          ),
                        ),
                      )
                    : MedicinesList(
                        dailyPills, getAllData, flutterLocalNotificationsPlugin!)
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: widget.showBackButton
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            : Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 0.0),
                  child: Container(
                    child: Image.asset(
                      'assets/icons/hamburger.png',
                      height: 16,
                      //color: MyTheme.dark_grey,
                      color: MyTheme.dark_grey,
                    ),
                  ),
                ),
              ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.title!.isNotEmpty
              ? Text(
                  widget.title!,
                  style: TextStyle(color: MyTheme.accent_color),
                )
              : Image.asset(
                  'assets/logo/appbar_icon.png',
                  fit: BoxFit.fitWidth,
                  height: 40,
                )
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        widget.showBackButton
            ? InkWell(
                onTap: () {
                  // ToastComponent.showDialog("Coming soon", context,
                  //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                },
                child: Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 12.0),
                    child: Image.asset(
                      'assets/bell.png',
                      height: 16,
                      color: MyTheme.dark_grey,
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return Address();
                  // }));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  child: Icon(
                    Icons.settings,
                    color: MyTheme.accent_color,
                  ),
                ),
              ),
      ],
    );
  }
}
/* 
 */

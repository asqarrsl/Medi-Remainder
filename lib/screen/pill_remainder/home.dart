import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medi_remainder/database/pill_remainder/repository.dart';
import 'package:medi_remainder/models/pill_remainder/calendar_day_model.dart';
import 'package:medi_remainder/models/pill_remainder/pill.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/notifications/pill_remainder/notifications.dart';
import 'package:medi_remainder/screen/pill_remainder/add_new_medicine/add_new_medicine.dart';
import 'package:medi_remainder/screen/pill_remainder/calendar/calendarex.dart';
import 'package:medi_remainder/screen/pill_remainder/medicines_list.dart';
import 'package:medi_remainder/screen/profile.dart';
import 'package:medi_remainder/uisections/drawer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.title, this.showBackButton = false}) : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentSlider = 0;

  File? _image;
  String? _imagepath;
  String? username;
  //-------------------| Flutter notifications |-------------------
  final Notifications _notifications = Notifications();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  //===============================================================

  //--------------------| List of Pills from database |----------------------
  List<Pill> allListOfPills = <Pill>[];
  final Repository _repository = Repository();
  List<Pill> dailyPills = <Pill>[];
  //=========================================================================

  //-----------------| Calendar days |------------------
  final CalendarDayModel _days = CalendarDayModel();
  List<CalendarDayModel>? _daysList;
  //====================================================

  //handle last choose day index in calendar
  int _lastChooseDay = 0;

  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
    loadImage();
    loadUserData();
    _daysList = _days.getCurrentDays();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfPills.clear();
    (await _repository.getAllData("Pills"))!.forEach((pillMap) {
      allListOfPills.add(Pill().pillMapToObject(pillMap));
    });
    chooseDay(_daysList![_lastChooseDay]);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final double deviceHeight =
        MediaQuery.of(context).size.height - statusBarHeight;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyTheme.bg_color,
      appBar: buildAppBar(statusBarHeight, context),
      drawer: MainDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // specify the location of the FAB
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: FloatingActionButton(
          // backgroundColor: MyTheme.whatsapp_color,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddNewMedicine(
                showBackButton: true,
                title: "Add Pills",
              );
            })).then((_) => setData());
          },
          tooltip: "Add Pills",
          child: Container(
            margin: EdgeInsets.all(0.0),
            child: Icon(Icons.add),
          ),
          elevation: 0.0,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  dailyPills.isEmpty
                      ? SizedBox(height: deviceHeight * 0.03)
                      : SizedBox(height: 0),
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
                          dailyPills, setData, flutterLocalNotificationsPlugin!)
                ],
              ),
            ]),
          ),
        ],
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
          Image.asset(
            'assets/logo/appbar_icon.png',
            fit: BoxFit.fitWidth,
            height: 40,
          )
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            // ToastComponent.showDialog("Coming soon", context,
            //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                'assets/bell.png',
                height: 16,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CalendarEx(
                showBackButton: true,
                title: "Calendar",
              );
            }));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Icon(
              Icons.calendar_month_outlined,
              color: MyTheme.accent_color,
            ),
          ),
        ),
      ],
    );
  }

  void chooseDay(CalendarDayModel clickedDay) {
    setState(() {
      _lastChooseDay = _daysList!.indexOf(clickedDay);
      for (var day in _daysList!) {
        day.isChecked = false;
      }
      CalendarDayModel chooseDay = _daysList![_daysList!.indexOf(clickedDay)];
      chooseDay.isChecked = true;
      dailyPills.clear();
      allListOfPills.forEach((pill) {
        DateTime pillDate =
            DateTime.fromMicrosecondsSinceEpoch(pill.time! * 1000);
        if (chooseDay.dayNumber == pillDate.day &&
            chooseDay.month == pillDate.month &&
            chooseDay.year == pillDate.year) {
          dailyPills.add(pill);
        }
      });
      dailyPills.sort((pill1, pill2) => pill1.time!.compareTo(pill2.time!));
    });
  }

  //===============================================================================
  void loadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveImage.getString("imagepath");
    });
  }

  void loadUserData() async {
    SharedPreferences saveName = await SharedPreferences.getInstance();
    setState(() {
      username = saveName.getString("username");
    });
  }
}

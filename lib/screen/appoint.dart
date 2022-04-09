import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:medi_remainder/controllers/appointment_controller.dart';
import 'package:medi_remainder/models/appointment.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/add_appoint_bar.dart';
import 'package:medi_remainder/screen/widgets/appointment_tile.dart';
import 'package:medi_remainder/screen/widgets/button.dart';
import 'package:medi_remainder/uisections/drawer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Appoint extends StatefulWidget {
  Appoint({Key? key, this.title, this.showBackButton = false})
      : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<Appoint> createState() => _AppointState();
}

class _AppointState extends State<Appoint> {
  DateTime _selectedDate = DateTime.now();
  final _appointmentController = Get.put(AppointmentController());
  var notifyHelper;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;

  get style => null;
  final List<Map> field = [];

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: buildAppBar(statusBarHeight, context),
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(),
              Column(
                children: [
                  _addAppointBar(),
                  _addDateBar(),

                  SizedBox(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: _appointmentController.appointmentList.length,
                      itemBuilder: (_, index) {
                        // ignore: avoid_print
                        print(_appointmentController.appointmentList.length);
                        Appointment appointment =
                            _appointmentController.appointmentList[index];
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                                child: FadeInAnimation(
                                    child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, appointment);
                                  },
                                  child: AppointmentTile(appointment),
                                )
                              ],
                            ))));
                      },
                    ),
                  )
                  //_showAppointments(),
                ],
              ),
              Container(
                height: 80,
              )
            ]),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context, Appointment appointment) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 4),
          height: appointment.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.32,
          color: Get.isDarkMode ? darkGreyClr : Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
              ),
              Spacer(),
              appointment.isCompleted == 1
                  ? Container()
                  : _bottomSheetButton(
                      label: "Appointment Completed",
                      onTap: () {
                        _appointmentController
                            .markAppointmentCompleted(appointment.id!);
                        Get.back();
                      },
                      clr: MyTheme.whatsapp_color,
                      context: context),
              _bottomSheetButton(
                  label: "Delete Appointment",
                  onTap: () {
                    _appointmentController.delete(appointment);

                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  context: context),
              SizedBox(
                height: 20,
              ),
              _bottomSheetButton(
                  label: "Close",
                  onTap: () {
                    Get.back();
                  },
                  clr: Colors.white,
                  isClose: true,
                  context: context),
              SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isClose == true
                      ? Get.isDarkMode
                          ? Colors.grey[600]!
                          : Colors.grey[300]!
                      : clr),
              borderRadius: BorderRadius.circular(20),
              color: isClose == true ? Colors.transparent : clr),
          child: Center(
            child: Text(
              label,
              // style: isClose
              //     ? titleStyle
              //     : titleStyle.copyWith(color: Colors.white),
            ),
          ),
        ));
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: MyTheme.splash_screen_color,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MyTheme.dark_grey)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyTheme.dark_grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: MyTheme.dark_grey)),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addAppointBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  // style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  // style: HeadingStyle,
                ),
              ],
            ),
          ),
          Button(
              label: "+Add Reminder",
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddAppointment()));
                _appointmentController.getAppointments();
              })
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
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
            child: Icon(Icons.settings_outlined),
          ),
        ),
      ],
    );
  }
}

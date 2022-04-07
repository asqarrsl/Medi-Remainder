import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medi_remainder/database/pill_remainder/repository.dart';
import 'package:medi_remainder/models/pill_remainder/medicine_type.dart';
import 'package:medi_remainder/models/pill_remainder/pill.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/notifications/pill_remainder/notifications.dart';
import 'package:medi_remainder/screen/pill_remainder/add_new_medicine/form_fields.dart';
import 'package:medi_remainder/screen/pill_remainder/add_new_medicine/medicine_type_card.dart';
import 'package:medi_remainder/screen/pill_remainder/platform_flat_button.dart';
import 'package:medi_remainder/screen/pill_remainder/snack_bar.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AddNewMedicine extends StatefulWidget {
  AddNewMedicine({Key? key, this.title, this.showBackButton = false})
      : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  _AddNewMedicineState createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();

  final Repository _repository = Repository();
  final Notifications _notifications = Notifications();

  //medicine types
  final List<String> weightValues = ["pills", "ml", "mg"];

  int noOfWeeks = 1;
  String? selectWeight;
  DateTime setDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

//list of medicines forms objects
  final List<MedicineType> medicineTypes = [
    MedicineType("Pill", Image.asset("assets/images/pills.png"), true),
    MedicineType("Capsule", Image.asset("assets/images/capsule.png"), false),
    MedicineType("Cream", Image.asset("assets/images/cream.png"), false),
    MedicineType("Drops", Image.asset("assets/images/drops.png"), false),
    MedicineType("Syrup", Image.asset("assets/images/syrup.png"), false),
    MedicineType("Syringe", Image.asset("assets/images/syringe.png"), false),
  ];

  @override
  void initState() {
    super.initState();
    selectWeight = weightValues[0];
    initNotification();
  }

//init notifications
  Future initNotification() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotification(context);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(statusBarHeight, context),
      backgroundColor: MyTheme.bg_color,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceHeight * 0.37,
                child: FormFields(
                    noOfWeeks,
                    selectWeight!,
                    popUpMenuItemChanged,
                    sliderChanged,
                    nameController,
                    amountController),
              ),
              SizedBox(
                height: deviceHeight * 0.035,
                child: FittedBox(
                  child: Text(
                    "Medicine form",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...medicineTypes.map(
                        (type) => MedicineTypeCard(type, medicineTypeCheck))
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              SizedBox(
                width: double.infinity,
                height: deviceHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openTimePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 2),
                              Text(
                                DateFormat.Hm().format(this.setDate),
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.access_time,
                                size: 23,
                                color: MyTheme.accent_color,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openDatePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 5),
                              Text(
                                DateFormat("dd.MM").format(this.setDate),
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.event,
                                  size: 23,
                                  color: MyTheme.accent_color,
                                ),
                              )
                            ],
                          ),
                          color: const Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: deviceHeight * 0.09,
                width: double.infinity,
                child: PlatformFlatButton(
                  handler: () async => savePill(),
                  color: MyTheme.accent_color,
                  buttonChild: const Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //slider changer
  void sliderChanged(double value) => setState(() => noOfWeeks = value.round());

  //choose popum menu item
  void popUpMenuItemChanged(String value) =>
      setState(() => selectWeight = value);

  //OPEN TIME PICKER (SHOW)
  //CHANGE CHOOSE PILL TIME
  Future<void> openTimePicker() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: "Choose Time")
        .then((value) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          value != null ? value.hour : setDate.hour,
          value != null ? value.minute : setDate.minute);
      setState(() => setDate = newDate);
    });
  }

  //SHOW DATE PICKER AND CHANGE CURRENT CHOOSE DATE
  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
    });
  }

  //=======================================================================================================

  //--------------------------------------SAVE PILL IN DATABASE---------------------------------------
  Future savePill() async {
    //check if medicine time is lower than actual time
    if (setDate.millisecondsSinceEpoch <=
            DateTime.now().millisecondsSinceEpoch ||
        amountController.text.isEmpty ||
        double.tryParse(amountController.text) == null ||
        nameController.text.isEmpty) {
      if (setDate.millisecondsSinceEpoch <=
          DateTime.now().millisecondsSinceEpoch) {
        snackbar.showSnack(
            "Check your medicine time and date", _scaffoldKey, null);
      }
      if (amountController.text.isEmpty) {
        snackbar.showSnack("Check your Amount", _scaffoldKey, null);
      }
      if (double.tryParse(amountController.text) == null) {
        snackbar.showSnack("Enter a Valid Amount", _scaffoldKey, null);
      }
      if (nameController.text.isEmpty) {
        snackbar.showSnack("Check your Name", _scaffoldKey, null);
      }
    } else {
      Pill pill = Pill(
          amount: amountController.text,
          noOfWeeks: noOfWeeks,
          medicineType: medicineTypes[medicineTypes
                  .indexWhere((element) => element.isChoose == true)]
              .name,
          name: nameController.text,
          time: setDate.millisecondsSinceEpoch,
          type: selectWeight!,
          notifyId: Random().nextInt(10000000));

      for (int i = 0; i < noOfWeeks; i++) {
        dynamic result =
            await _repository.insert("PillRemainder", pill.pillToMap());
        if (result == null) {
          snackbar.showSnack("Something went wrong", _scaffoldKey, null);
          return;
        } else {
          //set the notification schneudele
          tz.initializeTimeZones();
          tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
          await _notifications.showNotification(
              pill.name!,
              pill.amount! + " " + pill.medicineType! + " " + pill.type!,
              time,
              pill.notifyId!,
              flutterLocalNotificationsPlugin!);
          setDate = setDate.add(const Duration(milliseconds: 604800000));
          pill.time = setDate.millisecondsSinceEpoch;
          pill.notifyId = Random().nextInt(10000000);
        }
      }
      snackbar.showSnack("Saved", _scaffoldKey, null);
      Navigator.pop(context);
    }
  }

  //Selecting Medicine Type
  void medicineTypeCheck(MedicineType medicine) {
    setState(() {
      medicineTypes.forEach((medicineType) => medicineType.isChoose = false);
      medicineTypes[medicineTypes.indexOf(medicine)].isChoose = true;
    });
  }

  //get time difference
  int get time =>
      setDate.millisecondsSinceEpoch -
      tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;

  //----------------------------App Bar----------------------------------------
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
                  child: Image.asset(
                    'assets/icons/hamburger.png',
                    height: 16,
                    //color: MyTheme.dark_grey,
                    color: MyTheme.dark_grey,
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

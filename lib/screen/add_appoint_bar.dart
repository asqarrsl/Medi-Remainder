import 'package:flutter/material.dart';
import 'package:flutter_project/controllers/appointment_controller.dart';
import 'package:flutter_project/models/appointment.dart';
import 'package:flutter_project/my_theme.dart';
import 'package:flutter_project/screen/widgets/button.dart';
import 'package:flutter_project/screen/widgets/input_field.dart';
import 'package:flutter_project/uisections/drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddAppointment extends StatefulWidget {
  AddAppointment({Key? key, this.title, this.showBackButton = false}) : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final AppointmentController _appointmentController = Get.put(AppointmentController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime="10:30pm";
  int _selectedRemind = 5;
  List <int> remindList = [
    5,
    10,
    15,
    20,
  ];
  int _selectedColor=0;
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;

  var primaryCr;

  get style => null;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(
              //     8.0,
              //     16.0,
              //     8.0,
              //     0.0,
              //   ),
              //   child: buildHomeCarouselSlider(context),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(
              //     8.0,
              //     16.0,
              //     8.0,
              //     0.0,
              //   ),
              //   child: buildHomeMenuRow(context),
              // ),
          //   ]),
          // ),
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(
          //         16.0,
          //         16.0,
          //         8.0,
          //         0.0,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Featured Categories",
          //             style: TextStyle(
          //               fontSize: 16,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ]),
          // ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(
          //       16.0,
          //       16.0,
          //       0.0,
          //       0.0,
          //     ),
          //     child: SizedBox(
          //       height: 154,
          //       child: buildHomeFeaturedCategories(context),
          //     ),
          //   ),
          // ),
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(
          //         16.0,
          //         16.0,
          //         8.0,
          //         0.0,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Featured Products",
          //             style: TextStyle(fontSize: 16),
          //           ),
          //         ],
          //       ),
          //     ),
              // SingleChildScrollView(
              //   child: Column(
              //     children: [
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(
                    //     4.0,
                    //     16.0,
                    //     8.0,
                    //     0.0,
                    //   ),
                    //   child: buildHomeFeaturedProducts(context),
                    // ),
              //     ],
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(left:20, right:20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Task",
                      style: HeadingStyle,),
                      InputField(title: "Appointment Title", hint:"Enter Appointment Title", controller: _titleController,),
                      InputField(title: "Doctor Name", hint:"Enter Doctor Name", controller: _nameController,),
                      InputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                      widget:IconButton(
                        icon: Icon(Icons.calendar_today_outlined),
                        color:MyTheme.dark_grey,
                        onPressed: (){
                          print("Hi there");
                          _getDateFromUser();
                        },
                      )
                      ),
                      Row(
                        children: [
                        Expanded(
                          child: InputField(
                            title: "Start Time",
                            hint: _startTime,
                            widget: IconButton(
                              onPressed: (){
                                  _getTimeFromUSer(isStarTime:true);
                              },
                              icon:Icon(
                                Icons.access_time_rounded,
                                color:MyTheme.dark_grey,
                              ),
                            ),
                            ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                            child: InputField(
                            title: "End Time",
                            hint: _endTime,
                            widget: IconButton(
                              onPressed: (){
                                  _getTimeFromUSer(isStarTime:false);
                              },
                              icon:Icon(
                                Icons.access_time_rounded,
                                color:MyTheme.dark_grey,
                              ),
                            ),
                            ),
                            ),
                      ],
                      ),
                      InputField(title: "Reminder", hint: "$_selectedRemind minutes early",
                      widget:DropdownButton(
                        icon: Icon(Icons.keyboard_arrow_down,
                        color: MyTheme.dark_grey,),
                        iconSize:32,
                        elevation:4,
                        style:subtitleStyle,
                        underline: Container(height: 0,),
                        onChanged:(String? newValue){
                          setState(() {
                            _selectedRemind = int.parse(newValue!);
                          });
                        },
                        items:remindList.map<DropdownMenuItem<String>>((int value)
                        {
                          return DropdownMenuItem<String>(
                              value:value.toString(),
                              child:Text(value.toString())
                          );
                        }
                        ).toList(), 
                      ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _collorPallete(),                     
                    SizedBox(     
                      width: 150,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: ()=>_validateDate(),child: Text("Create Appointment"),),
                    )
                  ],
                  ),
                  ],
                  
                  ),
                )
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
AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor : Colors.white,
      leading: GestureDetector(
        onTap: () {
          
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
          Container(
            //  margin: const EdgeInsets.only(left: 75),
            child: Image.asset(
              'assets/logo/appbar_icon.png',
              fit: BoxFit.fitWidth,
              height: 40,
            ),
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
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return Address();
            // }));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Icon(
              Icons.settings,
              color: MyTheme.accent_color,
            ),
          ),
        ),
      ],
    );
  }
_validateDate(){

  if(_titleController.text.isNotEmpty&&_nameController.text.isNotEmpty){
    _addAppointmentToDb();
    Get.back();
  }else if(_titleController.text.isEmpty || _nameController.text.isEmpty){
    Get.snackbar("Required", "All Fields are required",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    icon:Icon(Icons.warning_amber_rounded)
    );
  }
}
_addAppointmentToDb() async{
 int value = await _appointmentController.addAppointment(
    appointment:Appointment(
    title: _titleController.text,
    name: _nameController.text,
    date:DateFormat.yMd().format(_selectedDate),
    startTime: _startTime,
    endTime: _endTime,
    remind:_selectedRemind,
    color:_selectedColor,
    isCompleted: 0,
  )
 );
 print("ID is "+"$value");
}
_collorPallete(){
  return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Color",
                          style: titleStyle,),
                          Wrap(
                            children: List <Widget>.generate(
                              3, 
                              (int index){
                                return GestureDetector(
                                  onTap: () {
                                      setState(() {
                                        _selectedColor = index;
                                        print("$index");
                                      });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: index == 0?Color.fromARGB(255, 11, 89, 223):index == 1?Colors.pink:Colors.yellowAccent,
                                      child: _selectedColor==index?Icon(Icons.done,
                                      color:Colors.white,
                                      size:16
                                      ):Container(),
                                    ),
                                  ),
                                );
                              }),
                          )
                        ],
                      );
}
_getDateFromUser() async{
  DateTime? _pickerDate = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2022), 
    lastDate: DateTime(2222),
    );

    if(_pickerDate!= null){
      _selectedDate = _pickerDate;
    }else{
      print("it's null");
    }
}

_getTimeFromUSer({required bool isStarTime}) async{
 var pickedTime = await  _showTimePicker();
 String _formatedTime = pickedTime.format(context);
 if(pickedTime == null){
   print("Time cancelled");
 }else if(isStarTime==true){
  setState(() {
     _startTime = _formatedTime;
  });
 }else if(isStarTime==false){
   setState(() {
     _endTime = _formatedTime;
   });

 }
}
_showTimePicker(){
  return showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
                    context: context, 
                    initialTime: TimeOfDay(
                      hour: int.parse(_startTime.split(":")[0]), 
                      minute:int.parse(_startTime.split(":")[1].split("")[0]), 
                      ),
                );
}

}
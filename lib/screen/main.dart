import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medi_remainder/my_theme.dart';
<<<<<<< HEAD
import 'package:medi_remainder/screen/home.dart';
import 'package:medi_remainder/screen/view-all-medicines.dart';
=======
import 'package:medi_remainder/screen/appoint.dart';
import 'package:medi_remainder/screen/home.dart';
>>>>>>> main
import 'package:pandabar/pandabar.dart';

class Main extends StatefulWidget {
  Main({Key? key, go_back = true}) : super(key: key);

  bool go_back = false;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
<<<<<<< HEAD
  var _children = [Home(), ViewAllMedicines(), Home(), Home(), Home()];
=======
  var _children = [Home(), Appoint(), Home(), Home(), Home()];
>>>>>>> main

  void onTapped(int i) {
    // if (!is_logged_in.$ && (i == 4 || i == 3)) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    //   return;
    // }
    setState(() {
      _currentIndex = i;
    });
    print("i$i");
  }

  void initState() {
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //specify the location of the FAB
      // floatingActionButton: Visibility(
      //   visible: MediaQuery.of(context).viewInsets.bottom ==
      //       0.0, // if the kyeboard is open then hide, else show
      //   child: FloatingActionButton(
      //     // backgroundColor: MyTheme.whatsapp_color,
      //     onPressed: () {},
      //     tooltip: "AI Councellor",
      //     child: Container(
      //         margin: EdgeInsets.all(0.0),
      //         child: IconButton(
      //             icon: new Image.asset('assets/icons/whatsapp_icon.png'),
      //             tooltip: 'Action',
      //             onPressed: () {
      //               // openwhatsapp();
      //               // Navigator.push(context,
      //               //     MaterialPageRoute(builder: (context) {
      //               //   return ChatScreen(showBackButton : true);
      //               // }));
      //               PandaBarButtonData(
      //                   id: 4, icon: Icons.person, title: 'Profile');
      //             })),
      //     elevation: 0.0,
      //   ),
      // ),
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        buttonColor: Theme.of(context).accentColor,
        fabColors: [
          MyTheme.accent_color,
          // MyTheme.accent_color,
          MyTheme.accent_color,
        ],
        fabIcon: Container(
          child: Icon(Icons.favorite_border, color: MyTheme.white),
        ),
        buttonData: [
          PandaBarButtonData(id: 0, icon: Icons.home, title: 'Home'),
<<<<<<< HEAD
          PandaBarButtonData(id: 1, icon: Icons.person, title: 'Profile'),
          PandaBarButtonData(id: 4, icon: Icons.person, title: 'Profile'),
          PandaBarButtonData(id: 4, icon: Icons.person, title: 'Profile'),
=======
          PandaBarButtonData(id: 1, icon: Icons.addchart, title: 'Appointment'),
          PandaBarButtonData(id: 4, icon: Icons.graphic_eq_sharp, title: 'Profile'),
          PandaBarButtonData(id: 4, icon: Icons.add_alert, title: 'Profile'),
>>>>>>> main
        ],
        onChange: (id) {
          setState(() {
            _currentIndex = id;
          });
        },
        onFabButtonPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return Filter(
          //     selected_filter: "products",
          //   );
          // }));
        },
      ),
    );
  }
}

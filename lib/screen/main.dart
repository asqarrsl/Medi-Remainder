import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/my_theme.dart';
import 'package:flutter_project/screen/appoint.dart';
import 'package:flutter_project/screen/home.dart';
import 'package:pandabar/pandabar.dart';

class Main extends StatefulWidget {
  Main({Key? key, go_back = true}) : super(key: key);

  bool go_back = false;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  var _children = [Home(), Appoint(), Home(), Home(), Home()];

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
          PandaBarButtonData(id: 1, icon: Icons.addchart, title: 'Appointment'),
          PandaBarButtonData(id: 4, icon: Icons.person, title: 'Profile'),
          PandaBarButtonData(id: 4, icon: Icons.person, title: 'Profile'),
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

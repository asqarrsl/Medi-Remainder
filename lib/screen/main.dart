import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/appoint.dart';
import 'package:medi_remainder/screen/home.dart';
import 'package:pandabar/pandabar.dart';

class Main extends StatefulWidget {
  Main({Key? key, go_back}) : super(key: key);

  bool go_back = false;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  var _children = [Home(), Appoint(), Home(), Home(), Home()];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
    print("i$i");
  }

  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_currentIndex],
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
          PandaBarButtonData(id: 4, icon: Icons.graphic_eq_sharp, title: 'Profile'),
          PandaBarButtonData(id: 4, icon: Icons.add_alert, title: 'Profile'),
        ],
        onChange: (id) {
          setState(() {
            _currentIndex = id;
          });
        },
        onFabButtonPressed: () {
        },
      ),
    );
  }
}
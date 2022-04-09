import 'package:flutter/material.dart';
import 'package:medi_remainder/screen/main.dart';
import 'package:medi_remainder/screen/profile.dart';


class MainDrawer extends StatefulWidget {
  MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
                  Container(),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_project/app_config.dart';
import 'package:flutter_project/my_theme.dart';
import 'package:flutter_project/screen/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.app_name,
      theme: ThemeData(
        primaryColor: MyTheme.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: MyTheme.accent_color,
      ),
      home: Splash(),
    );
  }
}